#!/usr/bin/env bash

. "$(dirname "$0")/lib/load.sh"

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
  local modules_dir="$1"

  setup_enabled_modules "$modules_dir"
  run_executable_files "$(enabled_module_files '*.sh')"
}

main() {
  main_title

  setup_modules "${script_dir}/modules"

  done_message
}

main
