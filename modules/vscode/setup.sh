#!/bin/bash

. "$(dirname "$0")/../../lib/load.sh"

link_settings_json() {
  h2 "Linking vscode settings"
  local vscode_user_dir="${HOME}/Library/Application Support/Code/User"
  local vscode_settings_json="${vscode_user_dir}/settings.json"
  local settings_json_file="${script_dir}/vscode-settings.json"

  ln -sf "$settings_json_file" "$vscode_settings_json"
}

main() {
  h1 "Setting up ${script_dir}"

  link_settings_json

  green_tick "Done"
}

main
