#!/usr/bin/env bash
set -Eeuo pipefail

cat <<'MESSAGE'
This script no longer rewrites the curated Arch package manifest from the
machine's installed package database. Use `pacman -Qq` when you need a local
inventory; review it before adding packages to resources/arch-packages.txt.
MESSAGE
