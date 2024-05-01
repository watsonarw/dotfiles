#!/bin/bash

. "$(dirname "$0")"/../../commons.sh

pkgs=(
  github.com/abiosoft/colima
  docker.com/cli
  docker.com/compose
  tldr.sh
  gitlab.com/OldManProgrammer/unix-tree
  github.com/aristocratos/btop
  stedolan.github.io/jq
  shellcheck.net
)

install_packages() {
  h2 "Installing packages with pkgx"
  bold "Installing ${pkgs[*]}"
  ${brew_bin_dir}/pkgx install "${pkgs[@]}"
}

main() {
  h1 "Setting up ${script_dir}"

  install_packages

  green_tick "Done"
}

main
