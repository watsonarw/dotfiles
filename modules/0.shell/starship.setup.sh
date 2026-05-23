#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

install_dir="${HOME}/.local/bin"

main() {
  style bold underline blue "Setting up starship"

  style bold "Installing or updating starship"

  curl -sS https://starship.rs/install.sh | sh -s -- \
    --bin-dir "$install_dir" \
    --yes

  style green "Starship setup complete"
}

main
