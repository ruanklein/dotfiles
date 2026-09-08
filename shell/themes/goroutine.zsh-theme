# A bright, minimal Oh My Zsh prompt for Go, Python, and Node.js projects.

: "${GOROUTINE_SHOW_OS_LOGO:=1}"
: "${GOROUTINE_SHOW_RUNTIMES:=1}"
: "${GOROUTINE_PROMPT:=}"

ZSH_THEME_GIT_PROMPT_CACHE=1
ZSH_THEME_GIT_PROMPT_PREFIX='%F{244} ['
ZSH_THEME_GIT_PROMPT_SUFFIX='%F{244}]%f'
ZSH_THEME_GIT_PROMPT_SEPARATOR=' %F{244}·%f '
ZSH_THEME_GIT_PROMPT_BRANCH='%F{207}%B'

typeset -g OMZ_OS_LOGO=''
typeset -g OMZ_OS_LOGO_READY=0

omz_os_logo() {
  (( OMZ_OS_LOGO_READY )) && {
    print -rn -- "$OMZ_OS_LOGO"
    return
  }

  local os_id='' key value

  if [[ $(uname -s) == Darwin ]]; then
    OMZ_OS_LOGO='%F{213}%f'
  elif [[ -r /etc/os-release ]]; then
    while IFS='=' read -r key value; do
      [[ $key == ID ]] || continue
      os_id=${value//\"/}
      break
    done < /etc/os-release

    case $os_id in
      ubuntu) OMZ_OS_LOGO='%F{202}%f' ;;
      fedora) OMZ_OS_LOGO='%F{141}%f' ;;
      arch|archlinux) OMZ_OS_LOGO='%F{45}%f' ;;
      opensuse*|sles) OMZ_OS_LOGO='%F{82}%f' ;;
      debian) OMZ_OS_LOGO='%F{197}%f' ;;
      gentoo) OMZ_OS_LOGO='%F{177}%f' ;;
      linuxmint|mint) OMZ_OS_LOGO='%F{77}󰣭%f' ;;
    esac
  fi

  OMZ_OS_LOGO_READY=1
  print -rn -- "$OMZ_OS_LOGO"
}

omz_project_stacks() {
  local dir=$PWD
  local has_go=0 has_python=0 has_node=0

  while :; do
    [[ -f $dir/go.mod ]] && has_go=1
    [[ -f $dir/pyproject.toml || -f $dir/requirements.txt || -f $dir/Pipfile || -f $dir/poetry.lock || -f $dir/uv.lock || -f $dir/setup.py || -f $dir/.python-version || -d $dir/.venv ]] && has_python=1
    [[ -f $dir/package.json || -f $dir/package-lock.json || -f $dir/pnpm-lock.yaml || -f $dir/yarn.lock || -f $dir/.nvmrc || -f $dir/.node-version || -f $dir/volta ]] && has_node=1

    (( has_go && has_python && has_node )) && break
    [[ $dir == / ]] && break
    dir=${dir:h}
  done

  (( has_go )) && print -r -- go
  (( has_python )) && print -r -- python
  (( has_node )) && print -r -- node
}

omz_runtime_version() {
  local runtime=$1 version

  command -v "$runtime" >/dev/null 2>&1 || return
  if [[ $runtime == go ]]; then
    version=$(go version 2>/dev/null) || return
  else
    version=$("$runtime" --version 2>/dev/null) || return
  fi

  case $runtime in
    go)
      version=${version#go version }
      version=${version%% *}
      version=${version#go}
      ;;
    python|python3) version=${version#Python } ;;
    node) version=${version#v} ;;
  esac

  print -rn -- "$version"
}

omz_runtime_segments() {
  local stack version

  for stack in ${(f)"$(omz_project_stacks)"}; do
    case $stack in
      go)
        version=$(omz_runtime_version go)
        [[ -n $version ]] && print -rn -- " %F{51}go%f %F{117}$version%f"
        ;;
      python)
        version=$(omz_runtime_version python)
        [[ -n $version ]] || version=$(omz_runtime_version python3)
        [[ -n $version ]] && print -rn -- " %F{226}python%f %F{75}$version%f"
        ;;
      node)
        version=$(omz_runtime_version node)
        [[ -n $version ]] && print -rn -- " %F{82}node%f %F{120}$version%f"
        ;;
    esac
  done
}

omz_prompt_suffix() {
  [[ -n $GOROUTINE_PROMPT ]] && print -rn -- " %B${GOROUTINE_PROMPT}%b"
}

omz_prompt_status() {
  local runtimes battery separator=''

  [[ $GOROUTINE_SHOW_RUNTIMES == 1 ]] && runtimes=$(omz_runtime_segments)
  if [[ -n $runtimes ]]; then
    print -rn -- "${runtimes# }"
    separator=1
  fi

  if (( $+functions[battery_pct_prompt] )); then
    battery=$(battery_pct_prompt)
    if [[ -n $battery ]]; then
      [[ -n $separator ]] && print -rn -- ' %F{244}·%f '
      print -rn -- "$battery"
      separator=1
    fi
  fi

  [[ -n $separator ]] && print -rn -- ' %F{244}·%f '
  print -rn -- '%F{244}%D{%H:%M}%f'
}

omz_prompt_context() {
  local logo display_dir

  [[ $GOROUTINE_SHOW_OS_LOGO == 1 ]] && logo=$(omz_os_logo)
  if [[ $PWD == $HOME || $PWD == $HOME/* ]]; then
    display_dir="~${PWD#$HOME}"
  else
    display_dir=$PWD
  fi

  [[ -n $logo ]] && print -rn -- "$logo "
  print -rn -- "%F{39}$display_dir%f"
  (( $+functions[git_super_status] )) && print -rn -- "$(git_super_status)"
  print -rn -- '%f'
}

setopt prompt_subst
PROMPT='$(omz_prompt_context)$(omz_prompt_suffix)
$(omz_prompt_status) '
RPROMPT=''
