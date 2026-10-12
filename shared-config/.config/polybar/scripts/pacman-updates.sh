#!/usr/bin/env bash

if ! command -v pacman >/dev/null 2>&1; then
    printf '0\n'
    exit 0
fi

pacman -Qu 2>/dev/null | awk 'END { print NR + 0 }'
