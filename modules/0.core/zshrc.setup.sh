#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly global_zshrc="${HOME}/.zshrc"

clear_global_zshrc() {
  rm -rf "${global_zshrc}"
}

include_in_global_zshrc() {
  local zshrc_file=$1

  style dim "Including ${zshrc_file}"

  echo ". ${zshrc_file}" >>"${global_zshrc}"
}

include_modular_zshrcs() {
  for FILE; do
    include_in_global_zshrc "$FILE"
  done
}

main() {
  style bold underline blue "Setting up zshrc"
  style bold "Resetting .zshrc file"

  clear_global_zshrc
  include_modular_zshrcs $(enabled_module_files '*.zshrc')

  style green "Zshrc setup complete"
}

main
