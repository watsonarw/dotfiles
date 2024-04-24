#!/bin/bash

. "$(dirname "$0")"/../../commons.sh

pkgs=(
  github.com/abiosoft/colima
  docker.com/cli
  docker.com/compose
  github.com/rupa/z
  tldr.sh
  gitlab.com/OldManProgrammer/unix-tree
  github.com/aristocratos/btop
  stedolan.github.io/jq
  shellcheck.net
)

install_packages() {
  bold "Installing ${pkgs[*]}"
  pkgx install "${pkgs[@]}"
}

main() {
  h1 "Installing packages with pkgx"

  install_packages

  green_tick "Installed pkgx"
}

main
