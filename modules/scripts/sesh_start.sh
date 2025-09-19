#!/usr/bin/env bash
sesh connect "$(
    sesh list --hide-duplicates -i | fzf --prompt ' ' \
        --border \
        --ansi \
        --preview-window 'right:60%' \
        --preview 'sesh preview {}' \
        --margin 10%
)"
