#!/bin/bash

. "$(dirname "$0")/../../lib/load.sh"

profile_json="${script_dir}/iterm-profiles.json"
PROFILE_NAME="AW"
DYNAMIC_PROFILES_DIR="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"

_link_iterm_profile() {
  mkdir -p "$DYNAMIC_PROFILES_DIR"
  ln -s -f "$profile_json" "$DYNAMIC_PROFILES_DIR/iterm-profiles.json"
}

_get_profile_guid() {
  jq -r ".Profiles[] | select(.Name == \"$PROFILE_NAME\") | .Guid" "$profile_json"
}

_set_iterm_profile_as_default() {
  local profile_guid="$(_get_profile_guid)"
  local ITERM_PREFS_PLIST="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"

  defaults write "${ITERM_PREFS_PLIST}" "Default Bookmark Guid" -string "${profile_guid}"

  green_tick "Default iTerm2 profile set"
}

_restart_iterm_message() {
  style green "Iterm profile has been set up."
  style bold "Note: Iterm needs to be restarted for changes to take effect"
}

main() {
  h1 "Setting up ${script_dir}"

  _link_iterm_profile
  _set_iterm_profile_as_default
  _restart_iterm_message

  green_tick "Done"
}

main
