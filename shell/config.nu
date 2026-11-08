$env.config.show_banner = false
$env.config.table.mode = 'rounded'
$env.config.buffer_editor = "hx"

$env.EDITOR = "hx"
$env.LS_COLORS = (vivid generate ayu)

alias nu-open = open
alias open = ^open

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
