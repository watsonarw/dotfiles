# This script is meant to be sourced, not executed.

command_exists() {
  type "$1" &>/dev/null
}
