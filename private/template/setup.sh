#!/bin/bash

. "$(dirname "$0")/../../commons.sh"

setup_brew_dependencies() {
  h2 "Install brew dependencies"
  brew bundle --file="${script_dir}/Brewfile"
}

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
    } >> "${global_zshrc}"
  fi
}

setup_sdks() {
  h2 "Setup SDKS"
  bold "Adding asdf plugins"

  local tool_versions_file=${script_dir}/.tool-versions

  set +e
  sed -E 's/([^ ]+) .*/\1/g' "$tool_versions_file" | xargs -n1 asdf plugin-add
  set -e

  bold "Installing tool versions"
  < "$tool_versions_file" xargs -n2 asdf install

  bold "Setting versions globally"
  < "$tool_versions_file" xargs -n2 asdf global

  asdf reshim
}

main() {
  h1 "Setting up ${script_dir}"

  setup_brew_dependencies
  setup_zsh_profile
  setup_sdks

  green_tick "Done ${script_dir}"
}

main
