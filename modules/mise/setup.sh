#!/bin/bash

. "$(dirname "$0")"/../../commons.sh

mise_config_file="${root_dir}/.config/mise/config.toml"
global_mise_config="${HOME}/.config/mise/config.toml"

activate_mise() {
  bold "Activate mise"
  # Activate for bash instead of zsh, only for the script
  eval "$(${brew_bin_dir}/mise activate bash)"
}

install_tool_versions() {
  bold "Installing tool versions"
  mise install -y
}

cleanup_old_versions() {
  bold "Cleaning up old versions"
  mise prune -y
}

main() {
  h1 "Setting up ${script_dir}"

  activate_mise
  install_tool_versions
  cleanup_old_versions

  green_tick "Done"
}

main
