# Load interactive Bash settings for login shells.
if [[ -r "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi

# Start the Xorg session only after logging in on the first virtual terminal.
if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" && "${XDG_VTNR:-}" == 1 ]] && command -v startx >/dev/null 2>&1; then
  exec startx
fi
