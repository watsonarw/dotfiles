#!/bin/sh

. $(dirname $0)/../commons.sh

main() {
  if ! command_exists brew; then
    h2 "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    green_tick "Installed Homebrew"
  fi

  h2 "Running brew bundle"
  brew bundle --file "${script_dir}/Brewfile"
  green_tick "Ran brew bundle"
}

main
