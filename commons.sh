set -euo pipefail

readonly script_name=$(basename "${0}")
readonly script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

command_exists () {
  type "$1" &> /dev/null ;
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

echo_bold() {
  echo "${BOLD}$1${RESET}"
}

h1() {
  echo_bold "========== $1 ==========\n"
}

h2() {
  echo_bold "----- $1 -----"
}

green_tick() {
  local message="${1-}"
  echo "${BOLD}${GREEN}✓${RESET} $message"
}

setup_color
