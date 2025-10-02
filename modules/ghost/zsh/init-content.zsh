fpath+=("$HOME/.zsh/deps")

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
	zvm_bindkey vicmd '^F' sesh_start 
}

export FZF_DEFAULT_OPTS=" \
	--color=bg+:-1,bg:-1,spinner:#F5E0DC,hl:#F38BA8 \
	--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
	--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
	--color=selected-bg:#45475A \
	--color=border:#313244,label:#CDD6F4"

source ~/.zsh/ctp-mocha.zsh
source ~/.zsh/git-aliases.zsh
source ~/.zsh/specter.zsh-theme
