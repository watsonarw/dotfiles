#!/bin/bash

. "$(dirname "$0")"/../commons.sh

main() {
  h1 "Setting up modules"

  run_executable_files "${root_dir}/modules/**/setup.sh"

  green_tick "Done setting up modules"
}

main
