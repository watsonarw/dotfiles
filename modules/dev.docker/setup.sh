#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

readonly docker_config_dir="${HOME}/.docker"
readonly docker_compose_plugin_target_path="${docker_config_dir}/cli-plugins/docker-compose"
readonly docker_compose_plugin_install_path="$(mise which docker-cli-plugin-docker-compose)"


link_docker_compose_plugin() {
  style bold "Linking docker compose plugin"
  safe_link_into_dir "$docker_compose_plugin_install_path" "$docker_compose_plugin_target_path"
}

main() {
  style bold underline blue "Setting up docker"

  link_docker_compose_plugin

  style green "Docker setup complete"
}

main
