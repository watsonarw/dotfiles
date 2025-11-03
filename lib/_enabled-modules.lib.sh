# This script is meant to be sourced, not executed.

no_modules_selected_message() {
  style red <<EOF
No modules were selected. Without any enabled modules, these scripts won't do anything.
${BOLD}Run this setup again and choose at least one module.
EOF
}

environment_modules_message() {
  blue "Modules from DOTFILES_ENABLED_MODULES environment variable:"
  bold "  ${DOTFILES_ENABLED_MODULES}"
}

selected_modules_message() {
  blue "You've selected the following modules:"
  bold "  ${DOTFILES_ENABLED_MODULES}"
}

persist_module_selection() {
  confirm_yes_no "Persist module selection? (requires zshrc module)" || return 0

  local module_persistence_module=".local-module-persistence"
  local module_persistence_dir="${modules_dir}/${module_persistence_module}"

  export DOTFILES_ENABLED_MODULES="${DOTFILES_ENABLED_MODULES} ${module_persistence_module}"

  mkdir -p "$module_persistence_dir"
  echo "export DOTFILES_ENABLED_MODULES=\"${DOTFILES_ENABLED_MODULES}\"" >"$module_persistence_dir/.zshrc"

  green_tick "Module selection persisted"
}

interactive_module_selection() {
  local selected_modules=()
  local module_list=($(ls "${modules_dir}"))

  blue "Starting interactive module selection."

  for module in "${module_list[@]}"; do
    confirm_yes_no "Enable module '${module}'?" && selected_modules+=("${module}")
  done

  export DOTFILES_ENABLED_MODULES="${selected_modules[*]:-}"
}

setup_enabled_modules() {
  export modules_dir="${1}"

  if [ -n "${DOTFILES_ENABLED_MODULES:-}" ]; then
    environment_modules_message
    confirm_yes_no "Use these modules?" && return 0
  fi

  interactive_module_selection

  if [ -n "${DOTFILES_ENABLED_MODULES}" ]; then
    selected_modules_message
    persist_module_selection
  else
    no_modules_selected_message
    exit 1
  fi
}

enabled_module_files() {
  local glob_within_module="$1"
  local all_found_files=()

  shopt -s nullglob dotglob

  for module in ${DOTFILES_ENABLED_MODULES}; do
    [[ -z "$module" ]] && continue
    local -a paths=($modules_dir/$module/$glob_within_module)
    for path in "${paths[@]:-}"; do
      [[ -f "$path" || -d $path ]] && all_found_files+=("$(resolve_canonical_path "$path")")
    done
  done

  shopt -u nullglob dotglob

  echo "${all_found_files[@]:-}"
}
