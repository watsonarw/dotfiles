#!/bin/sh

. $(dirname $0)/../commons.sh

readonly ssh_dir="${HOME}/.ssh"
readonly ssh_config_file="${ssh_dir}/config"
readonly ssh_key_file=${ssh_dir}/github-id_ed25519

check_ssh_config() {
  touch "${ssh_config_file}"
  cat "${ssh_config_file}" | grep -E "Hostname\s+github\.com$"
}

setup_ssh_config() {
  echo "Setting up ssh config"
  if [ -z "$(check_ssh_config)" ]; then
    cat >> "${ssh_config_file}" <<EOF

Host github.com
  Hostname github.com
  IdentityFile ${ssh_key_file}
EOF
  green_tick "set config is setup"
  else
    echo "ssh config is already set up for github.com"
  fi
}

github_fail_message() {
  printf "${RED}"
  cat <<EOF
Failed to connect to github. I might automate this one day, but for now you'll
need to manually create the ssh key and add it to the github account.

You can use the command below to create the key

ssh-keygen -t ed25519 -f ${ssh_key_file} -n <email-address>
EOF
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

setup_git_config() {
  local gitconfigs_dir="${HOME}/.gitconfigs"
  echo "Setting up git config"
  cat > "${HOME}/.gitconfig" <<EOF
[include]
  path = ~/.dotfiles/files/.gitconfig
EOF
  mkdir -p "${gitconfigs_dir}"
  touch "${gitconfigs_dir}/private"
}

main() {
  h2 "Setting up github ssh"
  setup_ssh_config
  setup_git_config
  ssh-add "${ssh_key_file}"

  validate_github_ssh

}

main
