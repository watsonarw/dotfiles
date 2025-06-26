#!/usr/bin/env bash

. "$(dirname "$0")/../../lib/load.sh"

readonly ssh_dir=${HOME}/.ssh
readonly ssh_config_file=${ssh_dir}/config

check_ssh_config() {
  grep -E "Host\s+\*$" "${ssh_config_file}"
}

setup_1password_ssh_agent() {
  h2 "Setting up 1password ssh agent"

  mkdir -p "${ssh_dir}"
  touch "${ssh_config_file}"

  mkdir -p ~/.1password && ln -sf ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

  if [ -z "$(check_ssh_config)" ]; then
    cat >>"${ssh_config_file}" <<EOF

Host *
  IdentityAgent "~/.1password/agent.sock"

EOF
    green_tick "set config is setup"
  else
    echo "ssh config is already set up to use 1password agent"
  fi
}

github_fail_message() {
  red "Failed to connect to github. Please make sure 1password is setup."
}

test_github_ssh() {
  ssh -T git@github.com
}

validate_github_ssh() {
  h2 "Checking ssh connection to github"
  set +e
  test_github_ssh
  if [ $? -eq 1 ]; then
    green_tick "Connection to github successful"
  else
    github_fail_message
    exit 1
  fi
  set -e
}

main() {
  h1 "Setting up ${script_dir}"

  setup_1password_ssh_agent
  validate_github_ssh

  green_tick "Done"
}

main
