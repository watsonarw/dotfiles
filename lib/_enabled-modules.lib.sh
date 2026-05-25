# This script is meant to be sourced, not executed.


readonly module_persistence_module=".module-persistence.local"

no_modules_selected_message() {
  style red "No modules were selected. Without any enabled modules, these scripts won't do anything."
  style bold red "Run this setup again and choose at least one module."
}

environment_modules_message() {
  style blue "Modules from DOTFILES_ENABLED_MODULES environment variable:"
  style bold "  ${DOTFILES_ENABLED_MODULES}"
}

selected_modules_message() {
  style blue "You've selected the following modules:"
  style bold "  ${DOTFILES_ENABLED_MODULES}"
}

persist_module_selection() {
  confirm_yes_no "Persist module selection? (requires 0.core module)" || return 0

  local module_persistence_dir="${modules_dir}/${module_persistence_module}"

  export DOTFILES_ENABLED_MODULES="${DOTFILES_ENABLED_MODULES} ${module_persistence_module}"

  mkdir -p "$module_persistence_dir"
  echo "export DOTFILES_ENABLED_MODULES=\"${DOTFILES_ENABLED_MODULES}\"" >"$module_persistence_dir/.zshrc"

  style dim green "Module selection persisted"
}

list_available_modules() {
  # ls is used to preserve the sort order
  ls "${modules_dir}"
}

interactive_module_selection() {
  local selected_modules=""

  style blue "Starting interactive module selection."

  for module in $(list_available_modules); do
    if confirm_yes_no "Enable module '${module}'?"; then
      selected_modules="${selected_modules:+$selected_modules }${module}"
    fi
  done

  export DOTFILES_ENABLED_MODULES="${selected_modules}"
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

  shopt -s dotglob

  for module in ${DOTFILES_ENABLED_MODULES}; do
    [ -z "$module" ] && continue

    for path in $modules_dir/$module/$glob_within_module; do
      [ -f "$path" ] || [ -d "$path" ] || continue
      resolve_canonical_path "$path"
    done
  done

  shopt -u dotglob
}
