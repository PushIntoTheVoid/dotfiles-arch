#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
cd -- "$DOTFILES_ROOT"

usage() {
    cat <<'USAGE'
Usage:
  ./setup.sh packages
  ./setup.sh aur PACKAGE [PACKAGE ...]
  ./setup.sh base
  ./setup.sh rice THEME
  ./setup.sh fetch-themes THEME [THEME ...]
  ./setup.sh all THEME
  ./setup.sh list-themes

Commands:
  packages     Install official Arch packages for the bspwm desktop.
  aur          Install explicitly named AUR packages through yay or paru.
  base         Install shared dotfiles, fonts, icons and helper scripts.
  rice THEME   Install one theme (for example: nord, horizon, dracula).
  fetch-themes Download multiple theme submodules without changing the active theme.
  all THEME    Install packages, base files and the selected theme.
  list-themes  Show themes available in this checkout.

The installer backs up changed files under ~/.local/state/dotfiles-backups/.
USAGE
}

command_name="${1:-}"
theme_name="${2:-}"

case "$command_name" in
    packages)
        exec "$DOTFILES_ROOT/setup-scripts/packages.sh"
        ;;
    aur)
        shift
        exec "$DOTFILES_ROOT/setup-scripts/aur-packages.sh" "$@"
        ;;
    base)
        exec "$DOTFILES_ROOT/setup-scripts/themes.sh"
        ;;
    rice)
        [[ -n "$theme_name" ]] || { usage >&2; exit 2; }
        exec "$DOTFILES_ROOT/setup-scripts/rices.sh" "$theme_name"
        ;;
    fetch-themes)
        shift
        exec "$DOTFILES_ROOT/setup-scripts/fetch-themes.sh" "$@"
        ;;
    all)
        [[ -n "$theme_name" ]] || { usage >&2; exit 2; }
        "$DOTFILES_ROOT/setup-scripts/packages.sh"
        "$DOTFILES_ROOT/setup-scripts/themes.sh"
        exec "$DOTFILES_ROOT/setup-scripts/rices.sh" "$theme_name"
        ;;
    list-themes)
        "$DOTFILES_ROOT/setup-scripts/rices.sh" --list
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac
