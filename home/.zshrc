# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

export PATH="/usr/local/sbin:$PATH"
# eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

. `brew --prefix`/etc/profile.d/z.sh

# Path to your oh-my-zsh installation.
export ZSH=/Users/ljones/.oh-my-zsh

export EDITOR='vim'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME=agnoster
ZSH_THEME=geometry
DEFAULT_USER=ljones

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#plugins
plugins=(git brew npm ruby bundler zsh-autosuggestions)

# User configuration
. `brew --prefix`/etc/profile.d/z.sh

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH:$HOME/bin"

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH

# export PATH="$HOME/.rbenv/bin:$PATH:$HOME/bin"
# eval "$(rbenv init -)"
source $ZSH/oh-my-zsh.sh
export PROJECTS_HOME=${HOME}/projects

#speed up escape in vim
# 10ms for key sequences
KEYTIMEOUT=1

ssh-add -A &> /dev/null
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
alias tas='tmux attach-session -t'
alias tagme='ctags -R --languages=ruby --exclude=.git --exclude=log .'
alias btagme='ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)'
alias buildst='git semaphore -s | jq '' .result'''
#env
source ~/.env
source ~/.after_sbrc
export NVM_DIR="/Users/ljones/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
