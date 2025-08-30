#!/usr/bin/env bash

swaylock --font "IosevkaTerm Nerd Font" \
    --clock \
    --indicator \
    --indicator-radius 100 \
    --indicator-thickness 8 \
    --timestr "%H:%M:%S" \
    --datestr "%a, %d/%m/%Y" \
    --ring-color cdd6f4 \
    --inside-color 1e1e2e \
    --line-color 00000000 \
    --text-color cdd6f4 \
    --fade-in 0.3 \
    --effect-blur 7x5 \
    --effect-vignette 0.3:0.3
