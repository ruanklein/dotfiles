# Dotfiles

Personal macOS development environment configuration.

## Contents

- `Brewfile`: Homebrew formulae, casks, and taps.
- `git/gitconfig`: Git configuration.
- `helix/config.toml`: Helix editor configuration.
- `shell/zshrc`: Zsh and Oh My Zsh configuration.
- `shell/themes/goroutine.zsh-theme`: Custom Oh My Zsh theme.

## Installation

Clone the repository:

```sh
git clone git@github.com:ruanklein/dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
```

Create symbolic links for the configuration files. Back up any existing files
at these destinations before running the commands.

```sh
mkdir -p "$HOME/.config/helix"

ln -s "$PWD/shell/zshrc" "$HOME/.zshrc"
ln -s "$PWD/git/gitconfig" "$HOME/.gitconfig"
ln -s "$PWD/helix/config.toml" "$HOME/.config/helix/config.toml"
```

Open a new Zsh session once to install Oh My Zsh automatically. Then link the
custom theme and reload Zsh:

```sh
mkdir -p "$HOME/.oh-my-zsh/custom/themes"
ln -s "$PWD/shell/themes/goroutine.zsh-theme" \
  "$HOME/.oh-my-zsh/custom/themes/goroutine.zsh-theme"
exec zsh
```

Install the Homebrew dependencies:

```sh
brew bundle --file Brewfile
```

## License

Distributed under the [MIT License](LICENSE).
