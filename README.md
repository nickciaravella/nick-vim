# Installation Instructions


## Neovim Configuration
### Mac OS
```shell
mv "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim-old
git clone git@github.com:nickciaravella/nick-vim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Windows
TODO

## Dependencies
### Install nerfonts (Meslo)
On a Mac you can do:
```shell
brew tap homebrew/cask-fonts
brew search nerd-font
brew install --cask <font>
```
For Mac-like font, use `font-meslo-lg-nerd-font`

Source: https://ohmyposh.dev/docs/installation/fonts

### RipGrep (faster telescope)
Follow the guide here: https://github.com/BurntSushi/ripgrep#installation


### C/C++ Compilers (Windows)

Install GCC compilers for treesitter - https://www.freecodecamp.org/news/how-to-install-c-and-cpp-compiler-on-windows/


# Resources

NeoVim-from-Scratch - https://github.com/LunarVim/NeoVim-from-Scratch

