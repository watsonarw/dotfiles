#!/bin/bash

. "$(dirname "$0")/../../commons.sh"

setup_zsh_profile() {
  local zshrc_file=${script_dir}/.zshrc
  local global_zshrc=${HOME}/.zshrc

  h2 "Setup ZSH profile"

  if ! grep "${zshrc_file}" "${global_zshrc}"; then
    echo "Adding ${zshrc_file} to ${global_zshrc}"
    {
      echo ""
      echo "# Remove ${script_dir} and re-run setup to cleanup"
      echo ". ${zshrc_file}"
    } >>"${global_zshrc}"
  fi
}

main() {
  h1 "Setting up ${script_dir}"

  setup_zsh_profile

  green_tick "Done ${script_dir}"
}

main
