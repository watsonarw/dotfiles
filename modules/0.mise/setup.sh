#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly mise_install_path="${HOME}/.local/bin/mise"
readonly mise_conf_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mise/conf.d"

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


link_mise_config() {
  local source_path=$1
  local module_name=$(basename "$(dirname "$source_path")")
  local filename=$(basename "$source_path")
  local symlink_path="${mise_conf_dir}/${module_name}.${filename}"

  style "Linking ${source_path}"

  safe_link_into_dir "${source_path}" "${symlink_path}"
}

link_mise_configs() {
  for FILE; do
    link_mise_config "$FILE"
  done
}

setup_modular_mise_config() {
  bold "Setting up mise config for modules"
  mkdir -p "${mise_conf_dir}"

  link_mise_configs $(enabled_module_files "mise.toml")
  link_mise_configs $(enabled_module_files "*.mise.toml")
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
  h2 "Installing and activating mise"
  install_and_activate_mise

  h2 "Setting up tools"
  setup_modular_mise_config
  install_tool_versions
  cleanup_old_versions

  green_tick "Done"
}

main
