#!/bin/bash

. "$(dirname "$0")"/../commons.sh

message() {
  cat <<EOF
|---------------------------------|
|       Setting up Modules        |
|---------------------------------|
EOF
}

main() {
  yellow "$(message)"

  run_executable_files "${root_dir}/modules/**/*.sh"

  green_tick "Done setting up modules"
}

main
