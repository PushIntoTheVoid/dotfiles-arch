#!/usr/bin/env bash
set -Eeuo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"
require_regular_user
require_command git

declare -A themes=(
    [ayu]=Ayu [doombox]=Doombox [dracula]=Dracula [forest]=Forest
    [gruvbox]=Gruvbox [gruvboxmaterial]=GruvboxMaterial [horizon]=Horizon
    [nord]=Nord [pinknord]=PinkNord [pinknordalternative]=PinkNordAlternative
    [solarizeddark]=SolarizedDark
)

(($# > 0)) || die "Usage: $0 THEME [THEME ...] (run './setup.sh list-themes' to see themes)"

declare -a theme_paths=()
declare -a resolved_themes=()
declare -A seen=()

for requested_theme in "$@"; do
    key="${requested_theme,,}"
    key="${key//-/}"
    key="${key//_/}"
    theme_dir="${themes[$key]:-}"
    [[ -n "$theme_dir" ]] || die "Unknown theme '$requested_theme'. Run './setup.sh list-themes' to see themes."

    if [[ -z "${seen[$theme_dir]:-}" ]]; then
        theme_paths+=("rices/$theme_dir")
        resolved_themes+=("$theme_dir")
        seen[$theme_dir]=1
    fi
done

printf 'Fetching %d theme(s) into %s; the active desktop configuration will not change.\n' \
    "${#theme_paths[@]}" "$DOTFILES_ROOT/rices"
git -C "$DOTFILES_ROOT" submodule update --init --depth 1 --recursive -- "${theme_paths[@]}"

for theme_dir in "${resolved_themes[@]}"; do
    [[ -f "$DOTFILES_ROOT/rices/$theme_dir/.config/current_theme" ]] ||
        die "Theme '$theme_dir' was fetched but did not provide .config/current_theme."
    printf 'Ready: %s\n' "$theme_dir"
done

printf 'All requested themes are ready. Select one with Super+Alt+T.\n'
