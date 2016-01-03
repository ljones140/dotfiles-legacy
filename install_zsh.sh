if [ "$SHELL" != "$(which zsh)" ]; then
  echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
  chsh -s `which zsh`
fi

env zsh
. ~/.zshrc
hup
