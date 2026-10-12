#!/usr/bin/env bash
set -Eeuo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"
require_regular_user
require_arch
require_command sudo

mapfile -t packages < <(sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$DOTFILES_ROOT/setup-scripts/resources/arch-packages.txt")
(( ${#packages[@]} > 0 )) || die 'The Arch package list is empty.'

printf 'Installing the bspwm desktop dependencies from the official Arch repositories.\n'
sudo pacman -Syu --needed "${packages[@]}"
