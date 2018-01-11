# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims":$PATH

. `brew --prefix`/etc/profile.d/z.sh

# Path to your oh-my-zsh installation.
export ZSH=/Users/lewis.jones/.oh-my-zsh

export EDITOR='vim'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME='geometry/geometry'
export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_COLORIZE_ROOT=true
export PROMPT_GEOMETRY_EXEC_TIME=true

# DEFAULT_USER=ljones
DEFAULT_USER=lewis.jones

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

#plugins
plugins=(git brew npm ruby bundler zsh-autosuggestions dotenv)
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

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
