#!/bin/bash

. "$(dirname "$0")/commons.sh"

main_title() {
  cat <<EOF
|---------------------------------|
|                                 |
|    Running main setup script    |
|                                 |
|---------------------------------|
EOF
}

done_message() {
  cat <<EOF

|---------------------------------|
|                                 |
|  Successfully completed setup   |
|                                 |
|---------------------------------|
EOF
}

main() {
  yellow "$(main_title)"

  run_executable_files "${root_dir}/setup/*"

  green "$(done_message)"
}

main
