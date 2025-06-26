#!/bin/bash

. "$(dirname "$0")/../../lib/load.sh"

global_mise_config="${HOME}/.config/mise/config.toml"
mise_install_path="${HOME}/.local/bin/mise"

install_and_activate_mise() {
  if ! command_exists mise; then
    echo "Mise is not active"

    bold "Checking for existing mise installation"

    if [ ! -e "${mise_install_path}" ]; then
      bold "Installing mise"
      curl https://mise.run | sh
    else
      echo "Mise is installed at ${mise_install_path}, skipping install..."
    fi

    bold "Activating mise"
    activate_mise
  fi

  green_tick "Mise is installed and activated"
}

activate_mise() {
  # Activate for bash instead of zsh, only for the script
  eval "$(${mise_install_path} activate bash)"
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

  install_and_activate_mise
  install_tool_versions
  cleanup_old_versions

  green_tick "Done"
}

main
