#!/usr/bin/env bash
set -Eeuo pipefail

if command -v bspc >/dev/null 2>&1 && pgrep -x bspwm >/dev/null 2>&1; then
    bspc wm -r
fi

if command -v notify-send >/dev/null 2>&1; then
    notify-send 'Theme applied' 'bspwm is reloading the selected configuration.' || true
fi
