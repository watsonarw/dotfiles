set_git_email() {
  local email=$1
  local mise_file=${2:-.mise.local.toml}

  mise set --file $mise_file GIT_AUTHOR_EMAIL="$1"
  mise set --file $mise_file GIT_COMMITTER_EMAIL="$1"
}
