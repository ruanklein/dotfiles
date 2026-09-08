# Dotfiles

Personal macOS development environment configuration.

## Contents

- `Brewfile`: Homebrew formulae, casks, and taps.
- `git/gitconfig`: Git configuration.
- `helix/config.toml`: Helix editor configuration.
- `shell/zshrc`: Zsh and Oh My Zsh configuration.
- `shell/themes/goroutine.zsh-theme`: Custom Oh My Zsh theme.

## Bootstrap

Install the Homebrew dependencies:

```sh
brew bundle --file Brewfile
```

Link or copy the configuration files you want to use into their corresponding
locations in your home directory. The shell configuration expects Oh My Zsh to
be installed at `~/.oh-my-zsh`.

## License

Distributed under the [MIT License](LICENSE).
