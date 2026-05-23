#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

vscode_user_dir="${HOME}/Library/Application Support/Code/User"

link_copilot_prompts() {
  style bold "Linking Copilot prompts"
  local vscode_prompts_dir="${vscode_user_dir}/prompts"
  local prompts_dir="${script_dir}/prompts"

  safe_link_into_dir "$prompts_dir" "$vscode_prompts_dir"
}

main() {
  style bold underline blue "Setting up Copilot"

  link_copilot_prompts

  style green "Copilot setup complete"
}

main
