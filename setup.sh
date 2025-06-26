#!/bin/bash

. "$(dirname "$0")/lib/load.sh"

_main_title() {
  style yellow invert <<EOF
|---------------------------------|
|                                 |
|    Running main setup script    |
|                                 |
|---------------------------------|
EOF
}

_done_message() {
  style green <<EOF
|---------------------------------|
|                                 |
|  Successfully completed setup   |
|                                 |
|---------------------------------|
EOF
}

main() {
  _main_title

  run_executable_files "${root_dir}/setup/*"

  _done_message
}

main

unset -f _main_title
unset -f _done_message
