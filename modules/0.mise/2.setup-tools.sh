#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly mise_conf_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mise/conf.d"

link_mise_config_with_module_name() {
  local source_path=$1
  local module_name
  module_name=$(basename "$(dirname "$source_path")")
  local symlink_path="${mise_conf_dir}/${module_name}.toml"

  style "Linking ${source_path}"

  link_with_conflict_prompt "${source_path}" "${symlink_path}"
}

link_mise_configs_in_directory() {
  for FILE; do
    link_mise_config_with_module_name "$FILE"
  done
}

setup_modular_mise_config() {
  bold "Setting up mise config for modules"
  mkdir -p "${mise_conf_dir}"

  link_mise_configs_in_directory $(enabled_module_files "mise.toml")
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
  h1 "Setting up mise tools"

  setup_modular_mise_config
  install_tool_versions
  cleanup_old_versions

  green_tick "Done"
}

main
