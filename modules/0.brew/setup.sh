#!/usr/bin/env bash

. "$(dirname "$0")/../../lib/load.sh"

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

install_homebrew() {
  bold "Checking for active brew installation"
  if ! command_exists brew; then
    echo "Brew is not active"
    bold "Checking for existing brew installation"

    if [ -z "$(brew_location)" ]; then
      h2 "Installing Homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      green_tick "Installed Homebrew"
    else
      echo "Brew is installed at $(brew_location), skipping install..."
    fi

    h2 "Activating homebrew"
    eval $($(brew_location) shellenv)
  else
    echo "Brew is installed and activated"
  fi
}

clear_global_brewfile() {
  rm -rf "${HOME}/.Brewfile"
  touch "${HOME}/.Brewfile"
}

include_in_global_brewfile() {
  local brewfile=$1
  echo "Including ${brewfile}"
  echo "instance_eval(File.read('$brewfile'))" >>"${HOME}/.Brewfile"
}

include_modular_brewfiles() {
  local file_glob=$1

  for FILE in $file_glob; do
    include_in_global_brewfile "$FILE"
  done
}

setup_global_brewfile() {
  h2 "Setting up global Brewfile"
  clear_global_brewfile
  include_modular_brewfiles "$(enabled_module_files '*.Brewfile')"
}

install_brew_deps() {
  h2 "Running brew bundle"
  brew bundle --global

}

main() {
  h1 "Setting up ${script_dir}"
  install_homebrew
  setup_global_brewfile
  install_brew_deps

  green_tick "Done"
}

main
