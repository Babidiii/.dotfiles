#!/usr/bin/env bash

DEF='\033[0m'
RED='\033[01;31m'
GRN='\033[01;32m'
YEL='\033[01;33m'

dmenu_disp(){
  dmenu -b -i -nb '#040404' -nf '#525252' -sf '#ffa0ff' -sb '#000000' -p "$1"
}

main(){
  declare -A images
  images=(
    ["kotlin"]="docker.io/gradle:7.3.2-jdk11-alpine"	# docker plugin
    ["java"]="docker.io/openjdk-17-slim"		# docker plugin
  )

  choices=$(echo "${!images[@]}" | sed 's/ /\n/g')
  choice="$( echo -e "${choices}" | dmenu_disp "DEV:")"

  [ -z ${choice} ] && printf "Error: empty string" && exit 1

  project_name="dev-${choice}"

	printf "* running container ${GRN}%s\n${DEF}" "${project_name}"
  printf "${YEL}podman run --rm -it -e TERM=xterm-256color -v $(pwd):/usr/src --name ${project_name} -w /usr/src --entrypoint /bin/sh ${images[$choice]}${DEF}\n"

  podman run --rm -it -e "TERM=xterm-256color" -v "$(pwd)":/usr/src --name ${project_name} -w /usr/src --entrypoint /bin/sh "${images[$choice]}"
}

main "${@}"
