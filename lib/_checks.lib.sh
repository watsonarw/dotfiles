# This script is meant to be sourced, not executed.

command_exists() {
  command -v "$1" >/dev/null 2>&1
}
