# This script is meant to be sourced, not executed.

safe_exec() {
	base_directory="$1"
	path_to_file="$2"
	shift 2  # Remove base_directory and path_to_file from $@

	if ! validate_safe_file_access "$base_directory" "$path_to_file"; then
		return 1
	fi

	if [ ! -x "$path_to_file" ]; then
		printf 'Error: "%s" is not executable\n' "$path_to_file" >&2
		return 1
	fi

	"$path_to_file" "$@"
}

run_executable_files() {
  base_directory="$1"
  shift

  for SCRIPT; do
    safe_exec "$base_directory" "$SCRIPT"
  done
}
