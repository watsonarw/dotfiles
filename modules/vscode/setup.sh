#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

vscode_user_dir="${HOME}/Library/Application Support/Code/User"

link_settings_json() {
  h2 "Linking vscode settings"
  local vscode_settings_json="${vscode_user_dir}/settings.json"
  local settings_json_file="$(resolve_canonical_path "${script_dir}/vscode-settings.json")"

  ln -sf "$settings_json_file" "$vscode_settings_json"
}

link_copilot_prompts() {
    h2 "Linking copilot prompts"
  local vscode_prompts_dir="${vscode_user_dir}/prompts"
  local prompts_dir="$(resolve_canonical_path "${script_dir}/prompts")"

  link_with_conflict_prompt "$prompts_dir" "$vscode_prompts_dir"
}

main() {
  h1 "Setting up ${script_dir}"

  link_settings_json
  link_copilot_prompts

  green_tick "Done"
}

main
