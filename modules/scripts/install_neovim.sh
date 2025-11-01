check_files() {
	if [ -d "$HOME/nixos/modules/nvim" ]; then 
		echo "log: nvim config present in NixOS config"
	else
		echo "err: no nvim config present in NixOS config (or no NixOS config)"
		exit 1
	fi
}

move_files() {
	if [ -d "$HOME/.config/nvim" ]; then
		echo "log: found exsting nvim config, deleting"
		rm -rf "$HOME/.config/nvim"
		mkdir -p "$HOME/.config/nvim" 
		cp -r "$HOME/nixos/modules/nvim/*"  ~/.config/nvim/
	else 
		echo "log: no found exsting nvim config"
		mkdir -p "$HOME/.config/nvim" 
		cp -r "$HOME/nixos/modules/nvim/*"  ~/.config/nvim/
	fi
}

exit_msg() {
	echo "install finished, exiting activation script"
	exit 0
}

main() { 
	check_files
	move_files
	exit_msg
}
