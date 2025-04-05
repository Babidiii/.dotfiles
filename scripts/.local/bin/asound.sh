#!/usr/bin/env sh

awk -F ' ' '/[0-9].*PRO X/ {
print "defaults.pcm.card " $1; 
print "defaults.ctl.card " $1
}' /proc/asound/cards > ~/.asoundrc 

