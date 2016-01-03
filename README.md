#Dotfiles

Here are my dotfiles. I have used homesick to create this repo/CASTLE using
homesick generate command. Homesick should help transfering to another machine.

https://github.com/technicalpickles/homesick

##Installation

###pre installation

based on this guide: http://jilles.me/badassify-your-terminal-and-shell/

```sh
brew install vim
brew install zsh
brew install z
brew install tmux
curl -L http://install.ohmyz.sh | sh
touch ~/.hushlogin
```

Will also need to install powerline fonts

###Installation

requires the homesick gem
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

Uses .homesickrc to install vundler.
```sh
homesick rc dotfiles
```
then in vim run :PluginInstall to get vundler to take the plugins.
