#!/bin/bash

. "$(dirname "$0")"/../commons.sh

readonly global_zshrc="${HOME}/.zshrc"

clear_global_zshrc() {
  rm -rf "${global_zshrc}"
}

include_in_global_zshrc() {
  local zshrc_file=$1

  echo "Including ${zshrc_file}"

  echo ". ${zshrc_file}" >>"${global_zshrc}"
}

include_modular_zshrcs() {
  local file_glob=$1

  for FILE in $file_glob; do
    include_in_global_zshrc "$FILE"
  done
}

main() {
  echo "Resetting .zshrc file"

  clear_global_zshrc
  include_modular_zshrcs "${root_dir}/modules/**/.zshrc"

  green_tick ".zshrc file reset"
}

main
