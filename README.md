#Dotfiles

Here are my dotfiles. I have used homesick to create this repo/CASTLE using
homesick generate command. Homesick should help transfering to another machine.

https://github.com/technicalpickles/homesick

##Installation

pre installation: http://jilles.me/badassify-your-terminal-and-shell/

```sh
brew install vim
brew install zsh
brew install z
brew install tmux
curl -L http://install.ohmyz.sh | sh
```

require the homesick gem
```sh
gem install homesick
```
```sh
homesick clone git@github.com:ljones140/dotfiles.git
```
once cloned then symlink the dotfiles
```sh
homesick symlink dotfiles
```
Install Vundler
```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
then in vim run :PluginInstall to get vundler to take the plugins.
