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
  echo $1

  local path=$1

  ${EDITOR:-vi} $path
}

setup_module_selection() {
  if [ ! -f "$module_selection_file" ]; then
    mkdir -p "$(dirname "${module_selection_file}")"
    echo "$(instructions)" >$module_selection_file
    ls ${modules_dir} >>$module_selection_file
    open_for_editing $module_selection_file
  fi
}

enabled_module_files() {
  local glob_within_module=$1

  local files_glob=""

  for module in $(grep -v '^#' $module_selection_file); do
    local module_files=("$modules_dir/$module/$glob_within_module")

    local num_files=$(ls -A1 ${module_files} 2>/dev/null | wc -l)

    if [ $num_files -gt 0 ]; then
      files_glob+=" ${module_files[@]}"
    fi
  done

  echo $files_glob
}
