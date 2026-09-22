# Dotfiles

Personal macOS development environment configuration.

## Contents

- `Brewfile`: Homebrew formulae, casks, and taps.
- `bin/awake`: Friendly wrapper for macOS `caffeinate`.
- `bin/hxai`: Sends Helix selections to Apple Intelligence through `fm`.
- `git/gitconfig`: Git configuration.
- `helix/config.toml`: Helix editor configuration.
- `fonts/`: MonacoFiraNerd font files for terminal use.
- `iterm2/com.googlecode.iterm2.plist`: iTerm2 profiles and preferences.
- `shell/zshrc`: Zsh and Oh My Zsh configuration.

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

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s "$PWD/shell/zshrc" "$HOME/.zshrc"
ln -s "$PWD/git/gitconfig" "$HOME/.gitconfig"
ln -s "$PWD/helix/config.toml" "$HOME/.config/helix/config.toml"
ln -s "$PWD/bin/awake" "$HOME/.local/bin/awake"
ln -s "$PWD/bin/hxai" "$HOME/.local/bin/hxai"
```

With a selection active in Helix, use `:pipe` with an instruction for Apple
Intelligence. The selected text is read from stdin and the generated response
is written back to Helix:

```text
:pipe hxai "Refactor this code while preserving its public API"
:pipe hxai "Fix bugs and return only replacement source code"
```

Install the terminal font before configuring the custom Zsh theme:

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
