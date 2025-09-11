#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

duplicate_config_error_message() {
  local conflicting_basenames="${1}"
  style red <<EOF
Error: Conflicting configs found in different modules:
  ${RESET}${BOLD}${conflicting_basenames}
Aborting. Please resolve conflicting modules and try again.
EOF
}

check_for_conflicting_configs() {
  local configs=${1:-}
  local basenames=$(printf "%s" "${configs[*]}" | xargs basename)

  local conflicting_basenames=$(printf "%s" "${basenames}" | sort | uniq -d)

  if [ -n "$conflicting_basenames" ]; then
    duplicate_config_error_message "${conflicting_basenames[*]}"
    exit 1
  fi
}

ensure_xdg_config_dir_exists() {
  mkdir -p ${XDG_CONFIG_HOME}
}

link_configs_in_xdg_base_path() {
  local configs_to_link=${1:-}
  local target_dir=${XDG_CONFIG_HOME}

  for path in ${configs_to_link[@]}; do
    link_with_conflict_prompt "$path" "$target_dir"
  done
}

main() {
  h1 "Setting up ${script_dir}"

  local xdg_config_files="$(enabled_module_files ".config/*")"

  check_for_conflicting_configs "$xdg_config_files"
  ensure_xdg_config_dir_exists
  link_configs_in_xdg_base_path "$xdg_config_files"

  green_tick "Done"
}

main
