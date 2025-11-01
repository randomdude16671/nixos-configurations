#!/usr/bin/env bash

swayidle -w \
    timeout 420 "$HOME/scripts/lock.sh" \
    resume 'killall -HUP swaylock'
