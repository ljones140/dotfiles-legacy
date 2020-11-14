# Dotfiles

Here are my dotfiles. I have used homesick to create this repo/CASTLE using
homesick generate command. Homesick should help transfering to another machine.

https://github.com/technicalpickles/homesick

## Installation

### pre installation

based on this guide: http://jilles.me/badassify-your-terminal-and-shell/

Oh My ZSH ihttp://ohmyz.sh/
```sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

```sh
brew install vim
brew install zsh
brew install z
brew install tmux
curl -L http://install.ohmyz.sh | sh
touch ~/.hushlogin
```

Will also need to install powerline fonts

### Installation

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

Vim Plug is being used for Vim plugins
https://github.com/junegunn/vim-plug


# Coc configuration

Trialing use of COC https://github.com/neoclide/coc.nvim to make vim more like
an IDE.

It's been set up with Solograph https://github.com/neoclide/coc-solargraph for
Ruby and a combination of vim-go and gopls for golang.
It's working great for Golang. Ruby takes a bit of setup.

At the moment I'm having to add `solargraph` gem to Gemfile of project.
