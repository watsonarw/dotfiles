#!/bin/bash

. "$(dirname "$0")"/../commons.sh

main() {
  local ZSH=${HOME}/.oh-my-zsh
  h1 "Setting up ohmyzsh"

  if [ ! -d "$ZSH" ]; then
    echo "Installing ohmyzsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    green_tick "Installed ohmyzsh"
  fi

  echo "Resetting .zshrc file"
  echo ". ${root_dir}/files/.zshrc" > "${HOME}/.zshrc"
  green_tick ".zshrc file reset"
}

main
