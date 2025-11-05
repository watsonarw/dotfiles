# This script is meant to be sourced, not executed.

resolve_canonical_path() {
	target_path="$1"

	if [ -f "$target_path" ]; then
		file_dir="$(dirname "$target_path")"
		file_name="$(basename "$target_path")"

		resolved_dir="$(cd "$file_dir" 2>/dev/null && pwd -P)" || return 1
		printf '%s/%s\n' "$resolved_dir" "$file_name"
	elif [ -d "$target_path" ]; then
		resolved_path="$(cd "$target_path" 2>/dev/null && pwd -P)" || return 1
		printf '%s\n' "$resolved_path"
	else
		return 1
	fi
}

is_path_contained() {
	resolved_base="$1"
	resolved_file="$2"

	case "$resolved_file" in
		"$resolved_base"/*) return 0 ;;
		"$resolved_base") return 0 ;;
		*) return 1 ;;
	esac
}

validate_safe_file_access() {
	base_directory="$1"
	path_to_file="$2"

	if [ ! -d "$base_directory" ]; then
		printf 'Error: base_directory "%s" is not a directory\n' "$base_directory" >&2
		return 1
	fi

	if [ ! -f "$path_to_file" ]; then
		printf 'Error: "%s" is not a regular file\n' "$path_to_file" >&2
		return 1
	fi

	if ! resolved_base_directory=$(resolve_canonical_path "$base_directory"); then
		printf 'Error: unable to resolve canonical path for base_directory "%s"\n' "$base_directory" >&2
		return 1
	fi

	if ! resolved_file_path=$(resolve_canonical_path "$path_to_file"); then
		printf 'Error: unable to resolve canonical path for file "%s"\n' "$path_to_file" >&2
		return 1
	fi

	if ! is_path_contained "$resolved_base_directory" "$resolved_file_path"; then
		printf 'Error: file "%s" (resolves to "%s") is outside base_directory "%s" (resolves to "%s")\n' \
			"$path_to_file" "$resolved_file_path" "$base_directory" "$resolved_base_directory" >&2
		return 1
	fi
}

safe_source() {
	base_directory="$1"
	path_to_file="$2"

	if ! validate_safe_file_access "$base_directory" "$path_to_file"; then
		return 1
	fi

	# shellcheck source=/dev/null
	. "$path_to_file"
}

# Usage: lib_exists <lib_directory> <lib_name>
# Checks if a library file named <lib_name>.lib.sh exists in the given <lib_directory>.
lib_exists() {
	base_path="$1"
	lib_name="$2"

	[ -f "$base_path/$lib_name.lib.sh" ]
}

# Usage: safe_load_lib <lib_directory> <pattern>
# Safely loads all libs matching <pattern>.lib.sh in the given <lib_directory>.
safe_load_lib() {
	base_path="$1"
	pattern="$2"

	while IFS= read -r lib_file; do
		safe_source "$base_path" "$lib_file"
	done < <(find "$base_path" -maxdepth 1 -name "${pattern}.lib.sh")
}

# Usage: load_libs <lib_directory>
# Safely loads all .lib.sh files in the given <lib_directory>.
load_libs() {
	target_dir="$1"
	safe_load_lib "$target_dir" "*"
}
