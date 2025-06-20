function sesh_start() {
	zle -I 
	{ 
		exec </dev/tty 
		exec <&1 
		~/scripts/sesh_start.sh
	}
	zle reset-prompt
}

function zvm_after_lazy_keybindings() {
	zvm_define_widget sesh_start
	zvm_bindkey vicmd '^K' sesh_start 
}

eval "$(batpipe)"
eval "$(batman --export-env)"

source ~/.zsh/ctp_mocha.zsh
export FZF_DEFAULT_OPTS=" \
	--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
	--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
	--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
	--color=selected-bg:#45475A \
	--color=border:#313244,label:#CDD6F4"
. <(fzf --zsh)
source ~/.zsh/git-aliases.zsh


autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%F{blue}git:(%F{red}%b%F{blue})%f %u%c'
zstyle ':vcs_info:git:*' actionformats '%F{blue}git:(%F{red}%b|%a%F{blue})%f %u%c'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}✗%f '
zstyle ':vcs_info:git:*' stagedstr '%F{green}✓%f '
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }
prompt_dir() {
	if [[ -n "$TMUX" ]]; then
		echo "%F{cyan}%B$(basename $PWD)%b%f"
	else
		echo "%F{cyan}%B%c%b%f"
	fi
}
prompt_arrow() {
	[[ $? -eq 0 ]] && echo "%F{green}>%f" || echo "%F{red}<%f"
}
setopt PROMPT_SUBST
PROMPT=' $(prompt_arrow)  $(prompt_dir) ${vcs_info_msg_0_}'
