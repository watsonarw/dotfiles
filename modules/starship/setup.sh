#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

install_dir="${HOME}/.local/bin"

main() {
  h1 "Setting up ${script_dir}"

  h2 "Installing or updating starship prompt"

  curl -sS https://starship.rs/install.sh | sh -s -- \
    --bin-dir "$install_dir" \
    --yes

  green_tick "Done"
}

main
