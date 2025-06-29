#!/usr/bin/env bash
sesh connect "$(
  sesh list --hide-duplicates -i | fzf --no-border \
    --ansi \
    --no-sort --prompt '⚡'\
    --preview-window 'right:60%' \
    --preview 'sesh preview {}' \
	--height 60% \
	--border 
)"
