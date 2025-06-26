# This script is meant to be sourced, not executed.

set -euo pipefail

script_name=$(basename "${0}")
readonly script_name
export script_name
root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
readonly root_dir
export root_dir
script_dir=$(cd "$(dirname "${0}")" && pwd)
readonly script_dir
export script_dir

_source_all_files() {
  local scripts_glob=$1

  for SCRIPT in $scripts_glob; do
    if [ -f "$SCRIPT" ]; then
      # shellcheck source=/dev/null
      . "$SCRIPT"
    fi
  done
}

_source_all_files "${root_dir}/lib/*.lib.sh"

unset -f _source_all_files
