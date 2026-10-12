#!/usr/bin/env bash

DOTFILES_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd -P)"
BACKUP_STAMP="$(date +%Y%m%d-%H%M%S-%N)"
BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-backups/$BACKUP_STAMP"

die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

require_regular_user() {
    [[ "$EUID" -ne 0 ]] || die 'Run this installer as your normal user; it invokes sudo only for package installation.'
}

require_arch() {
    [[ -r /etc/os-release ]] || die 'This installer supports Arch Linux only.'
    # shellcheck disable=SC1091
    source /etc/os-release
    [[ "${ID:-}" == arch || " ${ID_LIKE:-} " == *' arch '* ]] || die 'This installer supports Arch Linux only.'
}

copy_tree_with_backup() {
    local source="$1" destination="$2" label="$3" backup_dir
    shift 3
    [[ -d "$source" ]] || die "Source directory not found: $source"
    mkdir -p -- "$destination"
    backup_dir="$BACKUP_ROOT/$label"
    mkdir -p -- "$backup_dir"
    rsync -a --backup --backup-dir="$backup_dir" "$@" -- "$source/" "$destination/"
}

copy_home_tree_with_backup() {
    local source="$1" destination="$2" label="$3"
    [[ -d "$source" ]] || die "Source directory not found: $source"
    copy_tree_with_backup "$source" "$destination" "$label"
}
