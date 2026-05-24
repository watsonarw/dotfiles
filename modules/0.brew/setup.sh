#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

: "${XDG_CONFIG_HOME:=${HOME}/.config}"
readonly global_brewfile="${XDG_CONFIG_HOME}/homebrew/Brewfile"

brew_location() {
  # Adapted from https://github.com/ohmyzsh/ohmyzsh/blob/HEAD/plugins/brew/brew.plugin.zsh
  local brew_location=''

  if [[ -x /opt/homebrew/bin/brew ]]; then
    brew_location="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    brew_location="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    brew_location="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    brew_location="$HOME/.linuxbrew/bin/brew"
  fi

  echo $brew_location
}

install_homebrew() {
  style bold underline yellow "Installing and activating Homebrew"
  style dim "Checking for active brew installation"
  if ! command_exists brew; then
    style dim "Brew is not active"
    style dim "Checking for existing brew installation"

    if [ -z "$(brew_location)" ]; then
      style bold "Installing Homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      style dim green "Installed Homebrew"
    else
      style dim "Brew is installed at $(brew_location), skipping"
    fi

    style bold "Activating homebrew"
    eval $($(brew_location) shellenv)
  else
    style dim "Brew is installed and activated"
  fi
}

clear_global_brewfile() {
  rm -rf "$global_brewfile"
  mkdir -p "$(dirname "$global_brewfile")"
  touch "$global_brewfile"
}

include_in_global_brewfile() {
  local brewfile=$1
  style dim "Including ${brewfile}"
  echo "instance_eval(File.read('$brewfile'))" >>"$global_brewfile"
}

include_modular_brewfiles() {
  for FILE; do
    include_in_global_brewfile "$FILE"
  done
}

setup_global_brewfile() {
  style bold underline yellow "Setting up global Brewfile"
  clear_global_brewfile
  include_modular_brewfiles $(enabled_module_files '*.Brewfile')
}

install_brew_deps() {
  style bold underline yellow "Running brew bundle"
  XDG_CONFIG_HOME="$XDG_CONFIG_HOME" brew bundle --global

}

main() {
  style bold underline blue "Setting up brew"

  install_homebrew
  setup_global_brewfile
  install_brew_deps

  style green "Brew setup complete"
}

main
