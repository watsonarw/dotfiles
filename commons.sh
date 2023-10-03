set -euo pipefail

readonly script_name=$(basename "${0}")
readonly root_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly script_dir=$( cd "$( dirname "${0}" )" && pwd )

command_exists () {
  type "$1" &> /dev/null ;
}

execute_file() {
  local filename="$1"

  /bin/bash "${filename}"
}

run_executable_files() {
  local scripts_glob=$1
  for SCRIPT in ${scripts_glob}; do
    if [ -f $SCRIPT -a -x $SCRIPT ]; then
      execute_file "$SCRIPT"
    fi
  done
}

source_all_files() {
  local scripts_glob=$1
  for SCRIPT in ${scripts_glob}; do
    if [ -f $SCRIPT ]; then
      . "$SCRIPT"
    fi
  done
}

source_all_files "./commons/*"
