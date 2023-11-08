#!/bin/bash

. "$(dirname "$0")"/../commons.sh

install_homebrew() {
  if ! command_exists brew; then
    h2 "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    green_tick "Installed Homebrew"
  fi
}

clear_global_brewfile() {
  rm -rf "${HOME}/.Brewfile"
}

link_global_brewfile() {
  h2 "Linking global Brewfile"
  clear_global_brewfile
  include_in_global_brewfile "${root_dir}/Brewfile"
}

install_brew_deps () {
  h2 "Running brew bundle"
  brew bundle --global

}

main() {
  h1 "Running homebrew setup"
  install_homebrew
  link_global_brewfile
  install_brew_deps

  green_tick "Homebrew setup complete"
}

main
