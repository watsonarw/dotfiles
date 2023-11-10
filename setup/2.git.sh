#!/bin/bash

. "$(dirname "$0")"/../commons.sh

readonly global_gitconfig_file=${HOME}/.gitconfig

clean_global_git_config() {
  echo "Cleaning global gitconfg"
  echo "" > "${global_gitconfig_file}"
}

setup_git_config() {
  local gitconfigs_dir=${HOME}/.gitconfigs

  h2 "Setting up git config"
  cat >> "${global_gitconfig_file}" <<EOF
[include]
  path = ${root_dir}/files/.gitconfig
EOF

  mkdir -p "${gitconfigs_dir}"
  touch "${gitconfigs_dir}/private"
}

setup_global_gitignore() {
  h2 "Setting up global gitignore"
  ln -sf "${root_dir}/files/.gitignore" "${HOME}/.gitignore"
}

main() {
  h1 "Setting up git config"

  clean_global_git_config
  setup_git_config
  setup_global_gitignore

  green_tick "Done"
}

main
