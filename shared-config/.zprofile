if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" && "${XDG_VTNR:-}" == 1 ]] && command -v startx >/dev/null 2>&1; then
  exec startx
fi

#if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; 
#then
    #startx
#fi
