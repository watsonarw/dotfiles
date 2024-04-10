#!/bin/bash

. "$(dirname "$0")"/../commons.sh

link_settings_json() {
  local vscode_user_dir="${HOME}/Library/Application Support/Code/User"
  local vscode_settings_json="${vscode_user_dir}/settings.json"
  local settings_json_file="${root_dir}/files/vscode-settings.json"

  ln -sf "$settings_json_file" "$vscode_settings_json"
}


main() {
  h1 "Linking vscode settings"

  link_settings_json

  green_tick "Linked vscode settings"
}

main
