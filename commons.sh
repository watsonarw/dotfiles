set -o errexit
set -o nounset
set -o pipefail

readonly script_name=$(basename "${0}")
readonly script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

command_exists () {
  type "$1" &> /dev/null ;
}

echo_bold() {
  echo -e "\033[1m$1\033[0m"
}

h1() {
  echo_bold "========== $1 ==========\n"
}

h2() {
  echo_bold "----- $1 -----"
}

green_tick() {
  local message=${1-}
  echo -e "\033[1;92m✓\033[0m $message"
}