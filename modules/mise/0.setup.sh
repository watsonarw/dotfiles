#!/bin/bash

. "$(dirname "$0")"/../../commons.sh

mise_config_file="${root_dir}/.config/mise/config.toml"
root_mise_config="${HOME}/.config/mise/config.toml"

activate_mise() {
  bold "Activate mise"
  . <(mise activate zsh)
}

reset_global_mise_config() {
  bold "Resetting global mise config"
  cp "${mise_config_file}" "${root_mise_config}"
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
  reset_global_mise_config
  install_tool_versions
  cleanup_old_versions

  green_tick "Done"
}

main
