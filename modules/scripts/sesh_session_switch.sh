#!/usr/bin/env bash

sesh connect "$(sesh list --hide-duplicates -i | fzf --margin 10% --ansi --border)"
