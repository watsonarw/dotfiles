export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_UPDATE_PROMPT="true"

plugins=(git z brew)

. $ZSH/oh-my-zsh.sh

export PATH="/usr/local/sbin:$PATH"

eval "$(mise activate zsh)"
