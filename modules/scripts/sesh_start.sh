#!/usr/bin/env bash
sesh connect "$(
    sesh list --hide-duplicates -i | fzf --prompt ' ' \
        --border \
        --ansi \
        --margin 10%
)"
