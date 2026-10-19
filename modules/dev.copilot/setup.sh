#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

copilot_home="${HOME}/.copilot"

link_copilot_customizations() {
  style bold "Linking Copilot customizations"

  safe_link_into_dir "${script_dir}/instructions" "${copilot_home}/instructions"
  safe_link_into_dir "${script_dir}/skills" "${copilot_home}/skills"
}

main() {
  style bold underline blue "Setting up Copilot"

  link_copilot_customizations

  style green "Copilot setup complete"
}

main
