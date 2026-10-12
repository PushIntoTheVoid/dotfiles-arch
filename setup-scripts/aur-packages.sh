#!/usr/bin/env bash
set -Eeuo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"
require_regular_user
require_arch
(( $# > 0 )) || die "Usage: $0 PACKAGE [PACKAGE ...]. Review each AUR package before installing it."

for package in "$@"; do
    [[ "$package" =~ ^[[:alnum:]][[:alnum:]@+_.-]*$ ]] || die "Invalid package name: $package"
done

if command -v paru >/dev/null 2>&1; then
    helper=paru
elif command -v yay >/dev/null 2>&1; then
    helper=yay
else
    die 'Install yay or paru yourself before using this optional AUR helper.'
fi

"$helper" -S --needed "$@"
