#!/usr/bin/env sh

mostused="brave\ngimp"

DMENU='dmenu -i -b -nb #000000 -nf #999999 -sb #000000 -sf #FfA0Aa'

$(echo ${mostused} | ${DMENU})

