bindkey -v

function sesh_start() {
    zle -I 
    {
        exec </dev/tty
        exec <&1 
        ~/scripts/sesh_start.sh
    }
    zle reset-prompt
}

zle -N sesh_start

bindkey -M vicmd "^f" sesh_start
bindkey -M viins "^f" sesh_start
