#!/bin/bash

. "$(dirname "$0")"/../commons.sh

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

main() {
  h1 "Installing packages with pkgx"

  if ! command_exists x; then
    bold "Activating pkgx"
    . <(pkgx --shellcode)
  fi

  bold "Installing ${pkgs[*]} with pkgx"
  pkgx install "${pkgs[@]}"

  green_tick "Installed pkgx"
}

main
