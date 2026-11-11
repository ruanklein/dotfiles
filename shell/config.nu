use std/util "path add"

$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.HOMEBREW_CELLAR = ($env.HOMEBREW_PREFIX | path join "Cellar")

path add ($env.HOMEBREW_PREFIX | path join "opt" "openjdk" "bin")
path add ($env.HOMEBREW_PREFIX | path join "bin")
path add ($env.HOMEBREW_PREFIX | path join "sbin")
path add ($nu.home-dir | path join ".orbstack" "bin")
path add ($nu.home-dir | path join "go" "bin")
path add ($nu.home-dir | path join ".local" "bin")

$env.PATH = ($env.PATH | uniq)

$env.config.show_banner = false
$env.config.table.mode = 'rounded'
$env.config.buffer_editor = "hx"

$env.LS_COLORS = (vivid generate ayu)

const custom_config = ($nu.default-config-dir | path join "custom.nu")
const custom_config_to_load = if ($custom_config | path exists) { $custom_config } else { null }
source-env $custom_config_to_load
