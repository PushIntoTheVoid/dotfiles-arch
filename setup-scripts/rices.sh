#!/usr/bin/env bash
set -Eeuo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"

declare -A themes=(
    [ayu]=Ayu
    [doombox]=Doombox
    [dracula]=Dracula
    [forest]=Forest
    [gruvbox]=Gruvbox
    [gruvbox-material]=GruvboxMaterial
    [horizon]=Horizon
    [nord]=Nord
    [pink-nord]=PinkNord
    [pink-nord-alternative]=PinkNordAlternative
    [solarized-dark]=SolarizedDark
)

if [[ "${1:-}" == --list ]]; then
    printf '%s\n' "${!themes[@]}" | sort
    exit 0
fi

require_regular_user
require_command git
require_command rsync

theme="${1:-}"
[[ -n "$theme" ]] || die "Usage: $0 THEME (run '$0 --list' to see themes)"
theme="${theme,,}"
theme_dir="${themes[$theme]:-}"
[[ -n "$theme_dir" ]] || die "Unknown theme '$theme'. Run '$0 --list' to see themes."

rice_path="$DOTFILES_ROOT/rices/$theme_dir"
git -C "$DOTFILES_ROOT" submodule update --init --depth 1 --recursive -- "rices/$theme_dir"
[[ -f "$rice_path/.config/current_theme" ]] || die "Theme '$theme' did not provide its configuration; check the submodule at $rice_path"

# Keep machine-specific editor state, shell histories and bookmarks out of the
# installed theme. These were accidentally included in some upstream rices.
mkdir -p -- "$HOME/.config"
copy_tree_with_backup "$rice_path" "$HOME" "rice-$theme" \
    --exclude='/.git' \
    --exclude='/.git/**' \
    --exclude='*/.git' \
    --exclude='*/.git/**' \
    --exclude='/.config/Code/**' \
    --exclude='/.config/Code - Insiders/**' \
    --exclude='/.config/JetBrains/**' \
    --exclude='/.config/gedit-dump.dconf' \
    --exclude='/.config/nitrogen/bg-saved.cfg' \
    --exclude='/.config/gtk-3.0/bookmarks' \
    --exclude='**/terminal/history/**' \
    --exclude='/README.md' \
    --exclude='/screenshot*' \
    --exclude='/.icons/**' \
    --exclude='/.themes/**' \
    --exclude='/.wallpapers/**'

for item in .icons .themes .wallpapers; do
    [[ -d "$rice_path/$item" ]] || continue
    copy_tree_with_backup "$rice_path/$item" "$HOME/$item" "rice-$theme-$item"
done

# The stock theme configs offer an optional AUR update listing. Use pacman's
# repository query so the desktop remains usable without yay/paru.
polybar_config="$HOME/.config/polybar/config"
if [[ -f "$polybar_config" ]] && grep -q 'yay -Qu' "$polybar_config"; then
    sed -i 's/yay -Qu/pacman -Qu/g' "$polybar_config"
fi
if [[ -f "$polybar_config" ]]; then
    sed -i 's/#d1c4e99/#d1c4e9/g' "$polybar_config"
fi

printf "Theme '%s' installed for %s. Restart bspwm or log in again to apply it.\n" "$theme" "${USER:-your user}"
printf 'Backups, when needed, are in %s\n' "$BACKUP_ROOT"
