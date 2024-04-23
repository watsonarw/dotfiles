#!/bin/bash

. "$(dirname "$0")"/../commons.sh

install_homebrew() {
  if ! command_exists brew; then
    h2 "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    green_tick "Installed Homebrew"

    h2 "Activating homebrew"
    . <(/usr/local/bin/brew shellenv)
  else
    brew upgrade
  fi
}

clear_global_brewfile() {
  rm -rf "${HOME}/.Brewfile"
}

include_in_global_brewfile() {
  echo "instance_eval(File.read('$1'))" >>"${HOME}/.Brewfile"
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
  include_in_global_brewfile "${root_dir}/Brewfile"
  include_modular_brewfiles "${root_dir}/brewfiles/*"
  include_modular_brewfiles "${root_dir}/modules/**/Brewfile"
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
