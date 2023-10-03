#!/bin/bash

. $(dirname $0)/../commons.sh

main() {
  h1 "Setting up private configs"

  run_executable_files "${script_dir}/private/**/setup.sh"

  green_tick "Done setting up private configs"
}

main
