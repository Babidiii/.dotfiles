#!/usr/bin/env sh

#-------- keyboard 
setxkbmap -layout fr -variant us 
# setxkbmap -layout fr -variant us-azerty 
setxkbmap -option caps:escape # capslock -> escp for vim

#-------- notification 
dunst & 

#-------- compositor
picom --no-fading-openclose --backend xr_glx_hybrid &
# glx &

#-------- Wallpaper/themes
# setbg ~/Pictures/wallpaper/away_in_silence_by_aenami_dd9hkf3.png
# wal --theme sexy-derp
# wal --theme ~/.dotfiles/utils/kanagawa-wal-theme.json
# wal --theme 3024.json

#-------- other 
# dwmblocks &
# dwmbar &

sh ~/.config/.screenlayout/default.sh

#-------- tiling window manager
exec bspwm
# exec dwm
