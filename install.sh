#!/usr/bin/env sh

cat <<EOF
⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄

  ██████╗  █████╗ ██████╗ ██╗██████╗ ██╗██╗██╗
  ██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗██║██║██║
  ██████╔╝███████║██████╔╝██║██║  ██║██║██║██║
  ██╔══██╗██╔══██║██╔══██╗██║██║  ██║██║██║██║
  ██████╔╝██║  ██║██████╔╝██║██████╔╝██║██║██║
  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═════╝ ╚═╝╚═╝╚═╝
                                      DOTFILES
⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄

EOF

RESET=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)

SEP="-------------------------------------------------"

print_title(){
  local level=${1} title=${2}
  local length title_deco=""

  printf '%s\n' "${BOLD}${title}${RESET}"
  
  if [ $level -eq 1 ]; then 
    length=${#title}
    for i in $(seq 0 $length); do title_deco="${title_deco}⠄"; done
    printf "%s\n" "${title_deco}"
  fi
}

log(){
  local level=${1}
  local bold_text=${2}
  local text=${3}
  local color verb length 
  local title_deco=""

  case $level in
    "info")
      color="${BLUE}"
      verb="INFO"
      ;;
    "error")
      color="${RED}"
      verb="ERROR"
      ;;
    "success")
      color="${GREEN}"
      verb="CHECK"
      ;;
    default)
      color="${RESET}"
      verb=""
  esac

  printf '%s\t%s%s\n' "${BOLD}${color}${verb}${RESET}" "${BOLD}${bold_text}${RESET}" "${text}"

}

is_command_installed(){
  local command_name=${1}
  if [ ! -n "$(command -v ${command_name})" ]; then
    log "error" "${command_name}" " command not installed"
  else
    log "success" "${command_name}" " command installed"
  fi
}

required_package(){
  print_title 2 "Utils tools"
  is_command_installed "git"
  is_command_installed "cmake"
  is_command_installed "make"
  is_command_installed "stow  "

  is_command_installed "bash"

  printf "\n"; print_title 2 "WM & status bar"
  is_command_installed "bspwm"
  is_command_installed "polybar"

  printf "\n"; print_title 2 "Music"
  is_command_installed "mpd"
  is_command_installed "mpc"
  is_command_installed "ncmpcpp"

  printf "\n"; print_title 2 "Media"
  is_command_installed "sxiv"

  printf "\n"; print_title 2 "Utils"
  is_command_installed "picom"
  is_command_installed "zathura"
  is_command_installed "nvim"
  is_command_installed "dunst"

  printf "\n"; print_title 2 ".dotfiles scripts"
  is_command_installed "setbg"
  
}

main(){
  print_title 1 "Check dependancies"
  required_package
  printf "\n"

  print_title 1 "Installing packages"
  printf "\n"
  print_title 1 "Adding configurations"
}

main "${@}"
