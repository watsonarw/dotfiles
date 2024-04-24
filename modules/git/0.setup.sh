#!/bin/bash

. "$(dirname "$0")/../../commons.sh"

readonly global_gitconfig_dir="${HOME}/.config/git"
readonly gitconfig_dir="${root_dir}/.config/git"

link_global_config() {
  h2 "Setting up global git config and gitignore"
  rm -rf "${global_gitconfig_dir}"
  ln -sF "${gitconfig_dir}" "${global_gitconfig_dir}"
}

main() {
  h1 "Setting up ${script_dir}"

  link_global_config

  green_tick "Done"
}

main
