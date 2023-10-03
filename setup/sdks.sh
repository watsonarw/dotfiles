#!/bin/bash

. "$(dirname "$0")"/../commons.sh

tool_versions_file=${root_dir}/.tool-versions
global_tool_versions_file=${HOME}/.tool-versions

main() {
  h1 "Installing sdks with asdf"
  bold "Adding asdf plugins"
  set +e
  < "$tool_versions_file" sed -E 's/([^ ]+) .*/\1/g' | xargs -n1 asdf plugin-add
  set -e

  bold "Installing tool versions"
  < "$tool_versions_file" xargs -n2 asdf install

  bold "Setting versions globally"
  ln -sf "$tool_versions_file" "$global_tool_versions_file"

  bold "Reshim asdf"
  asdf reshim

  green_tick "Installed SDKs from $tool_versions_file"
}

main
