#!/usr/bin/env bash

. "$(dirname "$0")/../lib/load.sh"

_message() {
  style blue <<EOF
|---------------------------------|
|       Setting up Modules        |
|---------------------------------|
EOF
}

main() {
  _message
  setup_enabled_modules
  run_executable_files "$(enabled_module_files '*.sh')"
}

main

unset -f _message
