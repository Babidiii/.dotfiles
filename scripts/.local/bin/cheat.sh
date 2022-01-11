#!/usr/bin/env sh

dmenu_disp(){
  dmenu -b -i -nb '#040404' -nf '#525252' -sf '#ffa0ff' -sb '#000000' -p "$1"
}

main(){
  choice="$(curl -s -S "https://cheat.sh/:list" | dmenu_disp "Cheat.sh:")"

  [ -z ${choice} ] && printf "Error: empty string" && exit 1
  curl -s -S "https://cheat.sh/${choice}"
}

main "${@}"
