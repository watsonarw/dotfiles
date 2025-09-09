#!/usr/bin/env bash

. "$(dirname "$0")/../../lib/load.sh"

vscode_user_dir="${HOME}/Library/Application Support/Code/User"

link_settings_json() {
  h2 "Linking vscode settings"
  local vscode_settings_json="${vscode_user_dir}/settings.json"
  local settings_json_file="${script_dir}/vscode-settings.json"

  ln -sf "$settings_json_file" "$vscode_settings_json"
}

link_copilot_prompts() {
    h2 "Linking copilot prompts"
  local vscode_prompts_dir="${vscode_user_dir}"
  local prompts_dir="${script_dir}/prompts"


  link_with_conflict_prompt "$prompts_dir" "$vscode_prompts_dir"
}

main() {
  h1 "Setting up ${script_dir}"

  link_settings_json
  link_copilot_prompts

  green_tick "Done"
}

main
