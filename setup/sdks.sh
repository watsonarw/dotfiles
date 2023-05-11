#!/bin/sh

. $(dirname $0)/../commons.sh

tool_versions_file="$(dirname ${script_dir}/..)/.tool-versions"
global_tool_versions_file="${HOME}/.tool-versions"

main() {
  h2 "Installing sdks with asdf"
  echo_bold "Adding asdf plugins"
  set +e
  cat $tool_versions_file | sed -E 's/([^ ]+) .*/\1/g' | xargs -n1 asdf plugin-add
  set -e

  echo_bold "Installing tool versions"
  asdf install

  echo_bold "Setting versions globally"
  ln -sf $tool_versions_file $global_tool_versions_file

  green_tick "Installed SDKs from $tool_versions_file"
}

main
