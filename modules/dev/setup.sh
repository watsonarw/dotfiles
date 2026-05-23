#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

vscode_user_dir="${HOME}/Library/Application Support/Code/User"

link_settings_json() {
  style bold "Linking VS Code settings"
  local vscode_settings_json="${vscode_user_dir}/settings.json"
  local settings_json_file="${script_dir}/vscode-settings.json"

  safe_link_into_dir "$settings_json_file" "$vscode_settings_json"
}

main() {
  style bold underline blue "Setting up dev tools"

  link_settings_json

  style green "Dev tools setup complete"
}

main
