#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

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
