#! /bin/bash

modules_dir="${root_dir}/modules"

_no_modules_selected_message() {
  cat <<EOF
${RED}No modules were selected. Without any enabled modules, these scripts won't do anything.
${BOLD}Either set ENABLED_MODULES or run this setup again and choose at least one module.
${RESET}
EOF
}

_environment_modules_message() {
  cat <<EOF
${BLUE}Modules from ENABLED_MODULES environment variable:${RESET}
  ${BOLD}${ENABLED_MODULES}${RESET}
EOF
}

_selected_modules_message() {
  cat <<EOF
${BLUE}You've selected the following modules:${RESET}
  ${BOLD}${ENABLED_MODULES}${RESET}
EOF
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

setup_module_selection() {
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

    for file in $modules_dir/$module/$glob_within_module; do
      [[ -f "$file" ]] && all_found_files+=("$file")
    done
  done

  shopt -u nullglob dotglob

  echo "${all_found_files[@]:-}"
}
