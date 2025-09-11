#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

main_title() {
  style yellow invert <<EOF
|---------------------------------|
|                                 |
|    Running main setup script    |
|                                 |
|---------------------------------|
EOF
}

done_message() {
  style green <<EOF
|---------------------------------|
|                                 |
|  Successfully completed setup   |
|                                 |
|---------------------------------|
EOF
}

setup_modules() {
  local modules_dir="$(resolve_canonical_path "$1")"

  setup_enabled_modules "$modules_dir"
  run_executable_files "$modules_dir" $(enabled_module_files '*.sh')
}

main() {
  main_title

  setup_modules "${script_dir}/modules"

  done_message
}

main
