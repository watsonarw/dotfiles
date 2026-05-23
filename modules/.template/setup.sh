#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

main() {
  style bold underline blue "Setting up <script>"

  style green "<Script> setup complete"
}

main
