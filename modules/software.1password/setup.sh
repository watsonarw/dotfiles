#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly ssh_dir=${HOME}/.ssh
readonly ssh_config_file=${ssh_dir}/config

check_ssh_config() {
  grep -E "Host\s+\*$" "${ssh_config_file}"
}

setup_1password_ssh_agent() {
  style bold underline yellow "Setting up 1Password SSH agent"

  mkdir -p "${ssh_dir}"
  touch "${ssh_config_file}"

  mkdir -p ~/.1password && ln -sf ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

  if [ -z "$(check_ssh_config)" ]; then
    cat >>"${ssh_config_file}" <<EOF

Host *
  IdentityAgent "~/.1password/agent.sock"

EOF
    style dim green "SSH config is set up"
  else
    style dim "SSH config is already set up"
  fi
}

github_fail_message() {
  style red "Failed to connect to GitHub. Please make sure 1Password is set up."
}

test_github_ssh() {
  ssh -T git@github.com
}

validate_github_ssh() {
  style bold underline yellow "Validating GitHub SSH"
  set +e
  test_github_ssh
  if [ $? -eq 1 ]; then
    style dim green "Connection to GitHub successful"
  else
    github_fail_message
    exit 1
  fi
  set -e
}

main() {
  style bold underline blue "Setting up 1Password"

  setup_1password_ssh_agent
  validate_github_ssh

  style green "1Password setup complete"
}

main
