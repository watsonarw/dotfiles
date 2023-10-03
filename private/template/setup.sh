#!/bin/sh

. $(dirname $0)/../../commons.sh

setup_brew_dependencies() {
  h2 "Install brew dependencies"
  brew bundle --file="${current_script_dir}/Brewfile"
}

setup_zsh_profile() {
  local zshrc_file="${current_script_dir}/.zshrc"
  local global_zshrc="${HOME}/.zshrc"

  h2 "Setup ZSH profile"

  if [ -z "$(cat ${global_zshrc} | grep ${zshrc_file})" ]; then
    echo "Adding ${zshrc_file} to ${global_zshrc}"
    echo "" >> ${global_zshrc}
    echo "# Remove ${current_script_dir} and re-run setup to cleanup" >> ${global_zshrc}
    echo ". ${zshrc_file}" >> ${global_zshrc}
  fi
}

setup_sdks() {
  h2 "Setup SDKS"
  bold "Adding asdf plugins"

  local tool_versions_file="${current_script_dir}/.tool-versions"

  set +e
  cat $tool_versions_file | sed -E 's/([^ ]+) .*/\1/g' | xargs -n1 asdf plugin-add
  set -e

  bold "Installing tool versions"
  cat $tool_versions_file | xargs -n2 asdf install

  bold "Setting versions globally"
  cat $tool_versions_file | xargs -n2 asdf global

  asdf reshim
}

main() {
  h1 "Setting up ${current_script_dir}"

  setup_brew_dependencies
  setup_zsh_profile
  setup_sdks

  green_tick "Done ${current_script_dir}"
}

main
