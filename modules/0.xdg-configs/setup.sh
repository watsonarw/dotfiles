#!/bin/bash

. "$(dirname "$0")/../../commons.sh"

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

_duplicate_config_error_message() {
  local conflicting_basenames="${1}"
  style red <<EOF
Error: Conflicting configs found in different modules:
${BOLD}${conflicting_basenames}
Aborting. Please resolve conflicting modules and try again.
EOF
}

_existing_config_message() {
  local dest_path="$1"
  style yellow <<EOF
Conflict: Existing config found at '${dest_path}'
${BOLD}Replacing this config might have unexpected side effects.
Please confirm before proceeding.
The existing config will be moved to '${dest_path}.bak'
EOF

}

_check_for_conflicting_configs() {
  local configs=${1:-}
  local basenames=$(echo "${configs[*]}" | xargs basename)

  local conflicting_basenames=$(printf "%s" "${basenames}" | sort | uniq -d)

  if [ -n "$conflicting_basenames" ]; then
    _duplicate_config_error_message "${conflicting_basenames[*]}"
    exit 1
  fi
}

_ensure_xdg_config_dir_exists() {
  mkdir -p ${XDG_CONFIG_HOME}
}

_link_configs_in_xdg_base_path() {
  local configs_to_link=${1:-}
  local target_dir=${XDG_CONFIG_HOME}

  bold "Linking configs to ${target_dir}"

  for path in ${configs_to_link[@]}; do
    filename=$(basename -- "$path")
    dest_path="$target_dir/$filename"

    blue "Linking config for ${filename}"

    if [ ! -L "$dest_path" ] && [ -e "$dest_path" ]; then
      _existing_config_message "$dest_path"

      if confirm_yes_no "Overwrite '$dest_path'?"; then
        style "Overwriting existing config at '$dest_path'"
        mv "$dest_path" "$dest_path.bak"
      else
        style "Not linking '$dest_path'."
        continue
      fi
    fi

    [[ -L ${dest_path} ]] && yellow "Note: Overwriting existing linked config at $dest_path"

    ln -s -n -f "$path" "$dest_path"
    green "Linked '$path' to '$dest_path'."
  done
}

main() {
  h1 "Setting up ${script_dir}"

  local xdg_config_files="$(enabled_module_files ".config/*")"

  _check_for_conflicting_configs "$xdg_config_files"
  _ensure_xdg_config_dir_exists
  _link_configs_in_xdg_base_path "$xdg_config_files"

  green_tick "Done"
}

main
