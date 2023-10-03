#!/bin/sh

. $(dirname $0)/commons.sh

main_title() {
  printf "${YELLOW}"
  cat <<EOF
|---------------------------------|
|                                 |
|    Running main setup script    |
|                                 |
|---------------------------------|
EOF
  printf "${RESET}"
}

done_message() {
  printf "${GREEN}"
  cat <<EOF
|---------------------------------|
|                                 |
|  Successfully completed setup   |
|                                 |
|---------------------------------|
EOF
  printf "${RESET}"
}

main() {
  main_title

  run_executable_files "${script_dir}/setup/*"

  done_message
}

main
