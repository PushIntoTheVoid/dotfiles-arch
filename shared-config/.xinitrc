#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -n "${DOTFILES_XKB_LAYOUT:-}" ] && command -v setxkbmap >/dev/null 2>&1; then
  setxkbmap "$DOTFILES_XKB_LAYOUT"
fi

if command -v xrdb >/dev/null 2>&1 && [ -r "$HOME/.Xresources" ]; then
  xrdb "$HOME/.Xresources" &
fi
exec bspwm

#source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK
#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
