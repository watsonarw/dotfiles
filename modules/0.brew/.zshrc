brew_location() {
  # Adapted from https://github.com/ohmyzsh/ohmyzsh/blob/HEAD/plugins/brew/brew.plugin.zsh
  local brew_location=''

  if [[ -x /opt/homebrew/bin/brew ]]; then
    brew_location="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    brew_location="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    brew_location="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    brew_location="$HOME/.linuxbrew/bin/brew"
  fi

  echo $brew_location
}

eval $($(brew_location) shellenv)
unset -f brew_location
