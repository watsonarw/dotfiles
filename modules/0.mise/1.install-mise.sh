#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly mise_install_path="${HOME}/.local/bin/mise"
readonly mise_conf_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mise/conf.d/"

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

  mise self-update -y

  green_tick "Mise is installed and activated"
}

activate_mise() {
  # Activate for bash instead of zsh, only for the script
  eval "$(${mise_install_path} activate bash)"
}


main() {
  h1 "Setting up ${script_dir}"

  install_and_activate_mise

  green_tick "Done"
}

main
