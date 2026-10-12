#!/bin/bash

bspc rule -a \* -o state=floating 
bspc desktop -f '^1'
kitty -e "${SHELL:-/bin/zsh}" -c "cd; bash $HOME/.scripts/dotfetch; exec ${SHELL:-/bin/zsh}"

