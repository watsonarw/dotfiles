#!/usr/bin/env zsh
set -euo pipefail
setopt GLOB_SUBST # Allows load_libs to work in zsh

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly ZIM_CONFIG_FILE=${XDG_CONFIG_HOME:-$HOME/.config}/zim/zimrc
readonly ZIM_HOME=${XDG_CACHE_HOME:-$HOME/.cache}/zim


install_zim() {
  style bold underline yellow "Installing zim"
  # Download zimfw plugin manager if missing.
  if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    style bold "Installing zimfw to ${ZIM_HOME}"

    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi

  . ${ZIM_HOME}/zimfw.zsh init

  zimfw upgrade

  style dim green "Zim is installed and up to date"
}

install_plugins() {
  style bold underline yellow "Installing plugins"
  zimfw install
}


main() {
  style bold underline blue "Setting up zim"

  install_zim
  install_plugins

  style green "Zim setup complete"
}

main
