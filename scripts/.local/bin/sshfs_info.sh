#!/bin/bash

RESET=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)

line='              ---'

log (){
  local header="${1}"
  local msg="${2}"
  printf "$BLUE$BOLD%s$RESET$BOLD %s %s $RESET\n" "${header}" "${line:${#header}}" "${msg}"
}


sshfs_info(){
  ## A counter, just to know whether a separator should be printed
  c=0

  ## Get the mounts
  mount -t fuse.sshfs | grep -oP '^.+?@\S+?:\K.+(?= on /)' |
    # Iterate over them
    while read mount; do
      printf " $YELLOW$BOLD%s %s$RESET$BOLD %d $RESET\n" "${line}" "Connection" ${i}

      ## Get the details of this mount. 
      data=$(mount | grep -w "$mount")
      log "Host/Target" "$(echo $data | awk -F ':' '{print $1}')"
      log "Remote dir" "$(echo $data | sed -E 's/(.+?@\S+):(.+)\s+on.*/\2/')"
      log "Local dir" "$(echo $data | sed -E 's/(.+?@\S+?):(.+)\s+on\s+(.+)\s+type.*/\3/')"
      log "Elapsed time" "$(ps -p $(pgrep -f "$mount") o etime= | sed 's/\s*//g')"

        let c++;

    done
}

sshfs_info
