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

run_executable_files() {
  local scripts_glob=$1
  for SCRIPT in ${scripts_glob}; do
    if [ -f $SCRIPT -a -x $SCRIPT ]; then
      execute_file "$SCRIPT"
    fi
  done
}

main() {
  main_title

  run_executable_files "${script_dir}/setup/*"

  done_message
}

main
