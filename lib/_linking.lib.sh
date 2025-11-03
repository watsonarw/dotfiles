# This script is meant to be sourced, not executed.

existing_file_message() {
  local path="$1"
  style yellow <<EOF
Existing file or directory '${path}', please confirm before proceeding.
The existing file or directory will be moved to '${path}.bak'
EOF
}

link_with_conflict_prompt() {
  local source_path="$1"
  local symlink_path="$2"

  if [ -L "$symlink_path" ]; then
    style yellow dim "Overwriting existing link at $symlink_path"
  elif [ -e "$symlink_path" ]; then
    existing_file_message "$symlink_path"

    if confirm_yes_no "Overwrite '$symlink_path'?"; then
      mv "$symlink_path" "$symlink_path.bak"
    else
      return 0
    fi
  fi

  local canonical_source=$(resolve_canonical_path "$source_path")
  ln -s -n -f "$canonical_source" "$symlink_path"
}

safe_link_into_dir() {
  local source_path="$1"
  local symlink_path="$2"

  mkdir -p "$(dirname "$symlink_path")"
  link_with_conflict_prompt "$source_path" "$symlink_path"
}
