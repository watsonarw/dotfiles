#!/bin/bash

. "$(dirname "$0")"/../commons.sh

_message() {
  cat <<EOF
${YELLOW}
|---------------------------------|
|       Setting up Modules        |
|---------------------------------|
${RESET}
EOF
}

main() {
  _message

  setup_enabled_modules

  run_executable_files "$(enabled_module_files '*.sh')"

  green_tick "Done setting up modules"
}

main

unset -f _message
