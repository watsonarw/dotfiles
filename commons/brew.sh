#! /bin/bash

brew_location() {
  # Adapted from https://github.com/ohmyzsh/ohmyzsh/blob/HEAD/plugins/brew/brew.plugin.zsh
  local _brew_location=''

  if [[ -x /opt/homebrew/bin/brew ]]; then
    _brew_location="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    _brew_location="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    _brew_location="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    _brew_location="$HOME/.linuxbrew/bin/brew"
  fi

  echo $_brew_location
}

brew_bin_dir=$(cd "$(dirname "$(brew_location)")" && pwd)
readonly brew_bin_dir
export brew_bin_dir
