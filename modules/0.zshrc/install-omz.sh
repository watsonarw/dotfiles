#!/bin/bash

. "$(dirname "$0")/../../lib/load.sh"

install_omz() {
  local ZSH=${HOME}/.oh-my-zsh
  h2 "Setting up ohmyzsh"

  if [ ! -d "$ZSH" ]; then
    echo "Installing ohmyzsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    green_tick "Installed ohmyzsh"
  fi
}

main() {
  h1 "Setting up ${script_dir}"

  install_omz

  green_tick "Done"
}

main
