#!/bin/bash

. "$(dirname "$0")/../../commons.sh"

link_vimrc() {
  h2 "Linking vscode settings"
  local global_vimrc="${HOME}/.vimrc"
  local vimrc_file="${script_dir}/.vimrc"

  ln -sf "$vimrc_file" "$global_vimrc"
}

main() {
  h1 "Setting up ${script_dir}"

  link_vimrc

  green_tick "Done"
}

main
