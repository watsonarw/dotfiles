#!/bin/bash

. "$(dirname "$0")"/../commons.sh

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
  include_modular_brewfiles "$(enabled_module_files 'Brewfile')"
}

install_brew_deps() {
  h2 "Running brew bundle"
  brew bundle --global

}

main() {
  h1 "Running homebrew setup"
  install_homebrew
  setup_global_brewfile
  install_brew_deps

  green_tick "Homebrew setup complete"
}

main
