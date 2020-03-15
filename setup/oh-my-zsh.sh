#!/bin/sh

. $(dirname $0)/../commons.sh

main() {
  local ZSH="${HOME}/.oh-my-zsh"
  local KEEP_ZSHRC=yes
  h2 "Setting up ohmyzsh"

  if [ ! -d "$ZSH" ]; then
    echo "Installing ohmyzsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    green_tick "Installed ohmyzsh"
  fi

  echo "Resetting .zshrc file"
  echo "source ${script_dir}/files/.zshrc" > ${HOME}/.zshrc
  green_tick ".zshrc file reset"
}

main
