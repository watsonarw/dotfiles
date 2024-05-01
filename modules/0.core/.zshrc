export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_UPDATE_PROMPT="true"

plugins=(git z brew)

. $ZSH/oh-my-zsh.sh

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
