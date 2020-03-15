#!/bin/sh

. $(dirname $0)/../commons.sh

main() {
  local ZSH="${HOME}/.oh-my-zsh"
  local KEEP_ZSHRC=yes

  if [ ! -d "$ZSH" ]; then
    h2 "Installing ohmyzsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    green_tick "Installed ohmyzsh"
  fi

  h2 "Resetting .zshrc file"
  echo "source ${script_dir}/files/.zshrc" > ${HOME}/.zshrc
  green_tick ".zshrc file reset"


}

main
