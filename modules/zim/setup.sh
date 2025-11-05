#!/usr/bin/env zsh
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly ZIM_CONFIG_FILE=${XDG_CONFIG_HOME:-$HOME/.config}/zim/zimrc
readonly ZIM_HOME=${XDG_CACHE_HOME:-$HOME/.cache}/zim


install_zim() {
  # Download zimfw plugin manager if missing.
  if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    style bold "Installing zimfw to ${ZIM_HOME}"

    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi

  . ${ZIM_HOME}/zimfw.zsh init

  zimfw upgrade

  green_tick "Zim is installed and up to date"
}

install_plugins() {
  zimfw install
}


main() {
  h1 "Setting up ${script_dir}"

  install_zim
  install_plugins

  green_tick "Done"
}

main
