# This script is meant to be sourced, not executed.

execute_file() {
  local filename=$1

  /bin/bash "${filename}"
}

run_executable_files() {
  local scripts=($1)

  for SCRIPT in "${scripts[@]}"; do
    if [ -f "$SCRIPT" ] && [ -x "$SCRIPT" ]; then
      execute_file "$SCRIPT"
    fi
  done
}
