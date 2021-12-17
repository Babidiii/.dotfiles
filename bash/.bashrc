# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
set -o vi

#----------------------------------------------------------------------------
# - Prompt
#----------------------------------------------------------------------------
if_failed(){
  [ $? -ne 0 ] && echo -e "\e[01;31m"
}
# -> [rikishi@toru ~]$  ($ = red if previous cmd failed)
PS1='\[\033[01;36m\][\u@\h\[\033[01;37m\] \W\[\033[01;36m\]]$(if_failed)\$\[\033[00m\] '

#----------------------------------------------------------------------------
# - Alias
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# - PATH to binaries folders
#----------------------------------------------------------------------------
export PATH=$PATH:$HOME/.local/bin	# important app bin
export PATH=$PATH:$HOME/.local/bin/status-bar	# status bar bash script
export PATH=$PATH:$HOME/.local/utils	# utils bash script bin

alias ll="ls -alhF --group-directories-first"

#----------------------------------------------------------------------------
# - XDG based dir clean up
# -> https://wiki.archlinux.org/title/XDG_Base_Directory
#----------------------------------------------------------------------------
#---- Dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
#------------------- CONFIG FILES
#---- Yarn
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
export PATH=$PATH:$HOME/.yarn/bin             # Yarn bin
#---- GDB history file and init file
export GDBHISTFILE="$XDG_DATA_HOME"/gdb/history
alias gdb="gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init"
#---- Inputrc -> ~/.inputrc for readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
#---- wget (.wgetrc, .wget-hsts)
# export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
#---- Rust (rustup, cargo)
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup    # rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo      # cargo
export PATH=$XDG_DATA_HOME/cargo/bin:$PATH    # update path to fit new dir
# source "$XDG_DATA_HOME/cargo/env"           # source cargo env
#---- Golang
export GOPATH="$XDG_DATA_HOME/go"
export PATH=$PATH:$XDG_DATA_HOME/go/bin   # Golang local path
export PATH=$PATH:/usr/local/go/bin       # Golang path
#---- AWS
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
#-------------------



#------------------- MAN 
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# For neovim nightly dev folder
export PATH="$PATH:$HOME/.dotfiles/scripts"

alias cpwd="pwd | xclip -sel clip"
alias vim="nvim"
export EDITOR="nvim"

