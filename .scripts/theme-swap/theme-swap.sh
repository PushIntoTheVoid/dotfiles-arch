#!/usr/bin/env bash
set -Eeuo pipefail

repo_file="$HOME/.config/dotfiles/repo"
repo_root="${DOTFILES_REPO:-}"
if [[ -z "$repo_root" && -r "$repo_file" ]]; then
    IFS= read -r repo_root < "$repo_file" || true
fi
[[ -n "$repo_root" && -x "$repo_root/setup-scripts/rices.sh" ]] || {
    printf 'Dotfiles repository path is not configured. Run ./setup.sh base first.\n' >&2
    exit 1
}

usage() {
    printf 'Usage: %s --rofi | --theme THEME\n' "${0##*/}"
}

theme=""
case "${1:-}" in
    --rofi|-r)
        command -v rofi >/dev/null 2>&1 || { printf 'rofi is not installed.\n' >&2; exit 1; }
        theme="$(rofi -dmenu -i -p 'Theme' < "$repo_root/.scripts/theme-swap/available-themes")"
        ;;
    --theme|-t)
        [[ -n "${2:-}" ]] || { usage >&2; exit 2; }
        theme="$2"
        ;;
    -h|--help)
        usage
        exit 0
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac

[[ -n "$theme" ]] || exit 0
"$repo_root/setup-scripts/rices.sh" "$theme"
"$repo_root/.scripts/theme-swap/after-theme-swap.sh"
