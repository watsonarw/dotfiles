#! /bin/bash

confirm_yes_no() {
  local prompt_message="$1"
  while true; do
    read -rp "${prompt_message} (y/n):" choice
    case "${choice}" in
    [Yy])
      return 0 # Yes
      ;;
    [Nn])
      return 1 # No
      ;;
    *)
      red "Invalid input. Please enter 'y' or 'n'."
      ;;
    esac
  done
}
