#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly iterm_profiles_dir="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
readonly iterm_prefs_plist="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"

get_profile_guid() {
  local profile_json="$1"
  local profile_name="$2"

  jq -r ".Profiles[] | select(.Name == \"$profile_name\") | .Guid" "$profile_json"
}

link_iterm_profile() {
  local profile_json="$1"

  mkdir -p "$iterm_profiles_dir"
  ln -s -f "$profile_json" "$iterm_profiles_dir/iterm-profiles.json"
}

set_iterm_profile_as_default() {
  local profile_json="$1"
  local profile_name="$2"

  local profile_guid="$(get_profile_guid $profile_json $profile_name)"

  defaults write "${iterm_prefs_plist}" "Default Bookmark Guid" -string "${profile_guid}"
}

restart_iterm_message() {
  green_tick "Iterm profile has been set up as default."
  style yellow "Note: Iterm needs to be restarted for changes to take effect"
}

main() {
  h1 "Setting up ${script_dir}"

  local profile_json="$(resolve_canonical_path "${script_dir}/iterm-profiles.json")"
  local profile_name="AW"

  link_iterm_profile $profile_json
  set_iterm_profile_as_default $profile_json $profile_name
  restart_iterm_message

  green_tick "Done"
}

main
