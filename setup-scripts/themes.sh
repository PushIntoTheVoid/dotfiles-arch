#!/usr/bin/env bash
set -Eeuo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"
require_regular_user
require_command rsync

printf 'Installing shared configuration for %s\n' "$HOME"
copy_home_tree_with_backup "$DOTFILES_ROOT/shared-config" "$HOME" shared-config

for item in .scripts .fonts .icons .themes .wallpapers; do
    [[ -d "$DOTFILES_ROOT/$item" ]] || continue
    copy_home_tree_with_backup "$DOTFILES_ROOT/$item" "$HOME/$item" "root-$item"
done
if [[ -d "$HOME/.fonts" ]] && command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f "$HOME/.fonts"
fi

if command -v nvim >/dev/null 2>&1 && [[ -r "$HOME/.config/nvim/init.vim" ]]; then
    if ! nvim --headless '+PlugInstall --sync' +qall; then
        printf 'Warning: Neovim plugins could not be installed; rerun :PlugInstall later.\n' >&2
    elif [[ -f "$HOME/.config/nvim/plugged/coc.nvim/package.json" ]] && command -v npm >/dev/null 2>&1; then
        if ! npm --prefix "$HOME/.config/nvim/plugged/coc.nvim" install; then
            printf 'Warning: coc.nvim dependencies could not be installed; rerun npm install in its plugin directory.\n' >&2
        fi
    fi
fi

mkdir -p -- "$HOME/.scripts"
if [[ ! -e "$HOME/.scripts/custom-autostart" ]]; then
    cat > "$HOME/.scripts/custom-autostart" <<'AUTOSTART'
#!/usr/bin/env bash
# Put personal applications to start with bspwm in this file.
AUTOSTART
    chmod 755 "$HOME/.scripts/custom-autostart"
fi

repo_file="$HOME/.config/dotfiles/repo"
mkdir -p -- "$(dirname -- "$repo_file")"
installed_repo=""
if [[ -r "$repo_file" ]]; then
    IFS= read -r installed_repo < "$repo_file" || true
fi
if [[ "$installed_repo" != "$DOTFILES_ROOT" ]]; then
    if [[ -e "$repo_file" ]]; then
        mkdir -p -- "$BACKUP_ROOT/.config/dotfiles"
        cp -a -- "$repo_file" "$BACKUP_ROOT/.config/dotfiles/repo"
    fi
    printf '%s\n' "$DOTFILES_ROOT" > "$repo_file"
fi

printf 'Shared configuration installed. Backups, when needed, are in %s\n' "$BACKUP_ROOT"
printf 'Start bspwm with startx after reviewing ~/.xinitrc.\n'
