#!/usr/bin/env bash
set -Eeuo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"
require_command git

declare -A themes=(
    [ayu]=Ayu [doombox]=Doombox [dracula]=Dracula [forest]=Forest
    [gruvbox]=Gruvbox [gruvbox-material]=GruvboxMaterial [horizon]=Horizon
    [nord]=Nord [pink-nord]=PinkNord [pink-nord-alternative]=PinkNordAlternative
    [solarized-dark]=SolarizedDark
)
theme="${1:-}"
[[ -n "$theme" ]] || die "Usage: $0 THEME"
theme="${theme,,}"
theme_dir="${themes[$theme]:-}"
[[ -n "$theme_dir" ]] || die "Unknown theme '$theme'. Run './setup.sh list-themes' to see themes."

git -C "$DOTFILES_ROOT" submodule update --init --depth 1 --recursive -- "rices/$theme_dir"
printf "Theme '%s' is available at %s\n" "$theme" "$DOTFILES_ROOT/rices/$theme_dir"
