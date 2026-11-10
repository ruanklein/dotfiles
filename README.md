# Dotfiles

Personal macOS development environment configuration.

## Contents

- `Brewfile`: Homebrew formulae, casks, and taps.
- `bin/awake`: Friendly wrapper for macOS `caffeinate`.
- `bin/hxai`: Sends Helix selections to Apple Intelligence through `fm`.
- `git/gitconfig`: Git configuration.
- `helix/config.toml`: Helix editor configuration.
- `starship`: Starship shell configuration.
- `fonts/`: MonacoFiraNerd font files for terminal use.
- `iterm2/com.googlecode.iterm2.plist`: iTerm2 profiles and preferences.
- `shell/config.nu`: nushell configuration

## Installation

Clone the repository:

```sh
git clone git@github.com:ruanklein/dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
```

Create symbolic links for the configuration files. Back up any existing files
at these destinations before running the commands.

```sh
mkdir -p "$HOME/.config/helix" "$HOME/.local/bin"

ln -s "$PWD/git/gitconfig" "$HOME/.gitconfig"
ln -s "$PWD/helix/config.toml" "$HOME/.config/helix/config.toml"
ln -s "$PWD/bin/awake" "$HOME/.local/bin/awake"
ln -s "$PWD/bin/hxai" "$HOME/.local/bin/hxai"
ln -s "$PWD/agents/AGENTS.md" "$HOME/.codex/AGENTS.md"
ln -s "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
ln -s "$PWD/shell/config.nu" "$HOME/Library/Application Support/nushell/config.nu"
```

In Nushell, configure the Starship autoload after linking `starship.toml`:

```nu
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```

To make Nushell the default login shell, add its executable path to
`/etc/shells` and pass the same path to `chsh`:

```nu
let nu_path = (which nu | get path.0)
if not ((open /etc/shells | lines) | any {|line| $line == $nu_path }) {
    $nu_path | sudo tee -a /etc/shells
}
chsh -s $nu_path
```

Start a new login session for the shell change to take effect.

With a selection active in Helix, use `:pipe` with an instruction for Apple
Intelligence. The selected text is read from stdin and the generated response
is written back to Helix:

```text
:pipe hxai "Refactor this code while preserving its public API"
:pipe hxai "Fix bugs and return only replacement source code"
```

Install the terminal font used by the iTerm2 profile:

```sh
cp "$PWD/fonts/"*.ttf "$HOME/Library/Fonts/"
```

Configure iTerm2 to load its preferences from the repository:

1. Open **Settings > General > Preferences**.
2. Enable **Load settings from a custom folder or URL** and select `$PWD/iterm2`.
3. Enable **Save changes to folder when iTerm2 quits**.
4. Restart iTerm2.

Do not use **Import All Settings and Data** or **Restore Window Arrangement**.

## Packages

Install the Homebrew dependencies:

```sh
brew bundle --file Brewfile
```

## License

Distributed under the [MIT License](LICENSE).
