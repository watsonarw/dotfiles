eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

for cmd in $(coreutils --list); do
    alias "$cmd=coreutils $cmd"
done
