#!/bin/bash

. "$(dirname "$0")"/../commons.sh

mise_config_file="${root_dir}/.config/mise/config.toml"
root_mise_config="${HOME}/.config/mise/config.toml"

main() {
  h1 "Installing sdks"

  bold "Resetting global mise config"
  cp "${mise_config_file}" "${root_mise_config}"

  bold "Installing tool versions"
  mise install -y

  bold "Cleaning up old versions"
  mise prune -y

  green_tick "Installed SDKs from ${mise_config_file}"
}

main
