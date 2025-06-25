#! /bin/bash

modules_dir="${root_dir}/modules"

_no_modules_selected_message() {
  style red <<EOF
No modules were selected. Without any enabled modules, these scripts won't do anything.
${BOLD}Run this setup again and choose at least one module.
EOF
}

_environment_modules_message() {
  blue "Modules from ENABLED_MODULES environment variable:"
  bold "  ${ENABLED_MODULES}"
}

_selected_modules_message() {
  blue "You've selected the following modules:"
  bold "  ${ENABLED_MODULES}"
}

_persist_module_selection() {
  confirm_yes_no "Persist module selection? (requires zshrc module)" || return 0

  local module_persistence_module=".local-module-persistence"
  local module_persistence_dir="${modules_dir}/${module_persistence_module}"

  export ENABLED_MODULES="${ENABLED_MODULES} ${module_persistence_module}"

  mkdir -p "$module_persistence_dir"
  echo "export ENABLED_MODULES=\"${ENABLED_MODULES}\"" >"$module_persistence_dir/.zshrc"

  green_tick "Module selection persisted"
}

_interactive_module_selection() {
  local selected_modules=()
  local module_list=($(ls "${modules_dir}"))

  blue "Starting interactive module selection."

  for module in "${module_list[@]}"; do
    confirm_yes_no "Enable module '${module}'?" && selected_modules+=("${module}")
  done

  export ENABLED_MODULES="${selected_modules[*]:-}"
}

setup_enabled_modules() {
  if [ -n "${ENABLED_MODULES:-}" ]; then
    _environment_modules_message

    confirm_yes_no "Use these modules?" && return 0
  fi

  _interactive_module_selection

  if [ -n "${ENABLED_MODULES}" ]; then
    _selected_modules_message
    _persist_module_selection
  else
    _no_modules_selected_message
    exit 1
  fi
}

enabled_module_files() {
  local glob_within_module="$1"

  local all_found_files=()

  shopt -s nullglob dotglob

  for module in ${ENABLED_MODULES}; do
    [[ -z "$module" ]] && continue

    for path in $modules_dir/$module/$glob_within_module; do
      [[ -f "$path" || -d $path ]] && all_found_files+=("$path")
    done
  done

  shopt -u nullglob dotglob

  echo "${all_found_files[@]:-}"
}
