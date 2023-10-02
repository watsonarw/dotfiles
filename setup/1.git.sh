#!/bin/sh

. $(dirname $0)/../commons.sh

readonly ssh_dir="${HOME}/.ssh"
readonly ssh_config_file="${ssh_dir}/config"
readonly global_gitconfig_file="${HOME}/.gitconfig"

check_ssh_config() {
  touch "${ssh_config_file}"
  cat "${ssh_config_file}" | grep -E "Host\s+\*$"
}

setup_ssh_config() {
  echo "Setting up ssh config"

  mkdir -p ~/.1password && ln -sf ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

  if [ -z "$(check_ssh_config)" ]; then
    cat >> "${ssh_config_file}" <<EOF

Host example.com # break glass for sites that 1password agent doesn't support. Must be above Host *
  Hostname example.com
  IdentityAgent "/private/tmp/com.apple.launchd.iBFPc8NjZo/Listeners"
  IdentityFile /Users/awatson.ssh/id_rsa

Host *
  IdentityAgent "~/.1password/agent.sock"

EOF
  green_tick "set config is setup"
  else
    echo "ssh config is already set up to use 1password agent"
  fi
}

github_fail_message() {
  printf "${RED}"
  echo "Failed to connect to github. Please make sure 1password is setup."
  printf "${RESET}"
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

clean_global_git_config() {
 echo "" > $global_gitconfig_file
}

setup_git_config() {

  local gitconfigs_dir="${HOME}/.gitconfigs"
  echo "Setting up git config"
  cat >> "${global_gitconfig_file}" <<EOF
[include]
  path = ${script_dir}/files/.gitconfig
EOF
  mkdir -p "${gitconfigs_dir}"
  touch "${gitconfigs_dir}/private"
}

setup_global_gitignore() {
  h2 "Setting up global gitignore"
  ln -sf "${script_dir}/files/.gitignore" "${HOME}/.gitignore"
}

main() {
  h2 "Setting up github ssh"
  clean_global_git_config
  setup_ssh_config
  setup_git_config

  validate_github_ssh

  setup_global_gitignore

  green_tick "Done"
}

main
