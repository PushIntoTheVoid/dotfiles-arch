#!/usr/bin/env bash
set -Eeuo pipefail

command -v polybar >/dev/null 2>&1 || { printf 'polybar is not installed.\n' >&2; exit 1; }
config="$HOME/.config/polybar/config"
[[ -r "$config" ]] || { printf 'Polybar config not found: %s (install a rice first).\n' "$config" >&2; exit 1; }

pkill -u "$(id -u)" -x polybar 2>/dev/null || true
for _ in {1..30}; do
    pgrep -u "$(id -u)" -x polybar >/dev/null 2>&1 || break
    sleep 0.1
done
if pgrep -u "$(id -u)" -x polybar >/dev/null 2>&1; then
    printf 'An existing Polybar process did not stop.\n' >&2
    exit 1
fi

polybar --config="$config" example &
