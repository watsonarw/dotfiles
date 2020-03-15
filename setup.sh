#!/bin/sh

. $(dirname $0)/commons.sh

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

execute_file() {
  local filename="$1"

  h1 "Running setup ${filename}"
  /bin/bash "${filename}"
}

main() {
  main_title
  for SCRIPT in ${script_dir}/setup/*; do
    if [ -f $SCRIPT -a -x $SCRIPT ]; then
      execute_file "$SCRIPT"
    fi
  done

  done_message
}

main
