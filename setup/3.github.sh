#!/bin/bash

. "$(dirname "$0")"/../commons.sh

github_fail_message() {
  red "Failed to connect to github. Please make sure 1password is setup."
}

test_github_ssh() {
  ssh -T git@github.com
}

validate_github_ssh() {
  echo "Checking ssh connection to github"
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
  h1 "Testing up github ssh"

  validate_github_ssh

  green_tick "Done"
}

main
