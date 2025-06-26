# This script is meant to be sourced, not executed.

existing_file_message() {
  local dest_path="$1"
  style yellow <<EOF
Existing file or directory '${dest_path}', please confirm before proceeding.
The existing file or directory will be moved to '${dest_path}.bak'
EOF
}

link_with_conflict_prompt() {
  local path="$1"
  local target_dir="$2"

  filename=$(basename -- "$path")
  dest_path="$target_dir/$filename"

  if [ ! -L "$dest_path" ] && [ -e "$dest_path" ]; then
    existing_file_message "$dest_path"

    if confirm_yes_no "Overwrite '$dest_path'?"; then
      mv "$dest_path" "$dest_path.bak"
    else
      continue
    fi
  fi

  [[ -L ${dest_path} ]] && style yellow dim "Overwriting existing link at $dest_path"

  ln -s -n -f "$path" "$dest_path"
}
