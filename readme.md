# .files

## Installation ##

Clone repo and setup:

```sh
git clone https://github.com/DarkPark/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow --verbose --target=$HOME atuin fish htop mc starship tmux vim
```

To remove all created symlinks:

```sh
stow --verbose --delete --target=$HOME atuin fish htop mc starship tmux vim
```
