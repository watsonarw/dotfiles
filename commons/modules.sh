#! /bin/bash

modules_dir="${root_dir}/modules"
module_selection_file="${root_dir}/state/enabled-modules.patch"

instructions() {
  cat <<EOF
# Select the modules that you want to install
# Lines starting with '#' will be ignored.

EOF
}

open_for_editing() {
  echo "$1"

  local path="$1"

  ${EDITOR:-vi} "$path"
}

setup_module_selection() {
  if [ ! -f "$module_selection_file" ]; then
    mkdir -p "$(dirname "${module_selection_file}")"
    instructions >"$module_selection_file"
    ls "${modules_dir}" >>"$module_selection_file"
    open_for_editing "$module_selection_file"
  fi
}

enabled_module_files() {
  local glob_within_module="$1"

  local all_found_files=()
  local module

  shopt -s nullglob dotglob

  while IFS= read -r module; do
    [[ -z "$module" || "$module" =~ ^# ]] && continue # Skip blank lines and disabled modules

    for file in $modules_dir/$module/$glob_within_module; do
      [[ -f "$file" ]] && all_found_files+=("$file")
    done
  done <"$module_selection_file"

  shopt -u nullglob dotglob

  echo "${all_found_files[@]-}"
}
