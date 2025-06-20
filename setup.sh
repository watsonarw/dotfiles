#!/bin/bash

. "$(dirname "$0")/commons.sh"

_main_title() {
  cat <<EOF
${YELLOW}
|---------------------------------|
|                                 |
|    Running main setup script    |
|                                 |
|---------------------------------|
${RESET}
EOF
}

_done_message() {
  cat <<EOF
${GREEN}
|---------------------------------|
|                                 |
|  Successfully completed setup   |
|                                 |
|---------------------------------|
${RESET}
EOF
}

main() {
  _main_title

  echo $root_dir

  run_executable_files "${root_dir}/setup/*"

  _done_message
}

main

unset -f _main_title
unset -f _done_message
