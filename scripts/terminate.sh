#!/usr/bin/env sh

DMENU='dmenu -p Terminate: -i -b -nb #000000 -nf #999999 -sb #000000 -sf #ff650C'
choice=$(printf "logout\nshutdown\nreboot\nsuspend\nlock" | ${DMENU})

case "$choice" in
  logout) bspc quit & ;;
  shutdown) sudo shutdown -h now & ;;
  reboot) sudo shutdown -r now & ;;
  suspend) sudo suspend & ;;
  lock) sudo slock  ;;
esac
