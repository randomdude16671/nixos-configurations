#!/bin/sh
set -eu

banner() {
    printf '%s\n' "(from: https://github.com/devtooligan/awesome-ascii-art.git)"
    printf '%s\n' "Hello! Here's a dino while you're waiting:"
    printf '%s\n' "                        / \`.   .'\\ \""
    printf '%s\n' "                .---.  <    > <    >  .---."
    printf '%s\n' "                |    \\  \\ - ~ ~ - /  /    |"
    printf '%s\n' "                 ~-..-~             ~-..-~"
    printf '%s\n' "             \\~~~\\.'                    \`./~~~/"
    printf '%s\n' "   .-~~^-.    \\__/                        \\__/"
    printf '%s\n' " .'  O    \\\\     /               /       \\\\  \\\\"
    printf '%s\n' "(_____,    \`._.\\'               |         }  \\/~~~/"
    printf '%s\n' " \`----.          /       }     |        /    \\__/"
    printf '%s\n' "       \`-.      |       /      |       /      \`. ,~~|"
    printf '%s\n' "           ~-.__|      /_ - ~ ^|      /- _      \`..-'   f: f:"
    printf '%s\n' "                |     /        |     /     ~-.     \`-. _||_||_"
    printf '%s\n' "                |_____|        |_____|         ~ - . _ _ _ _ _>"
}

banner 

sep() {
    echo "------"
}

print_bold_color() {
    BOLD="\x1b[1m"
    RED="\x1b[1;31m"
    YELLOW="\x1b[1;33m"
    GREEN="\x1b[1;32m"
    CYAN="\x1b[1;36m"
    RESET="\x1b[0m"
    if [ "$#" -ne 2 ]; then
        sep
        printf '%b\n' "${RED}error${RESET}: script error: function print_bold_color: takes 2 arguments"
        sep
        exit 1
    fi
    text="$1"
    color="$2"

    case "$color" in
        "green")
            printf '%b\n' "${GREEN}${text}${RESET}"
            ;;
        "red")
            printf '%b\n' "${RED}${text}${RESET}"
            ;;
        "white")
            printf '%b\n' "${BOLD}${text}${RESET}"
            ;;
        "yellow")
            printf '%b\n' "${YELLOW}${text}${RESET}"
            ;;
        "cyan")
            printf '%b\n' "${CYAN}${text}${RESET}"
            ;;
        *)
            printf '%b\n' "${YELLOW}[WARN]${RESET} Color not implemented"
            ;;
    esac
}

if command -v git >/dev/null 2>&1; then
    print_bold_color "Found git, continuing" "green"
    sep 
else
    print_bold_color "Git is not in system packages. Add it and then run this script again" "red" 
    exit 1
fi

LOCAL_PLUGIN_INSTALLATION_DIR="$HOME/Programming/"
NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

check_local_plugin_dir() {
    mkdir -p "$HOME/Programming"
}

check_cmd() {
    if "$@"; then
        print_bold_color "command: $* executed successfully\n" "green"
    else
        print_bold_color "command: $* failed unexpectedly\n" "red"
        sep
        exit 1
    fi
}

lazydev_clone_and_update() {
    check_local_plugin_dir
    if [ ! -d "$LOCAL_PLUGIN_INSTALLATION_DIR/lazydev.nvim/" ]; then
        print_bold_color "Local lazydev.nvim not cloned, cloning..." "cyan"
        cd "$LOCAL_PLUGIN_INSTALLATION_DIR"
        check_cmd git clone https://github.com/randomdude16671/lazydev.nvim.git "$LOCAL_PLUGIN_INSTALLATION_DIR/lazydev.nvim/" --branch 'vim-deprecated-fix-11.0'
        print_bold_color "Cloned." "green"
        sep 
    else
        sep 
        print_bold_color "Found local plugin installed. Updating..." "cyan"
        (
            cd "$LOCAL_PLUGIN_INSTALLATION_DIR/lazydev.nvim"
            check_cmd git pull
            print_bold_color "Pulled the latest changes" "cyan"
        )
        sep 
    fi
}

if [ -f "$NVIM_CONFIG/init.lua" ]; then
    print_bold_color "Neovim config found. Updating it..." "cyan"
    sep 
    (
        cd "$NVIM_CONFIG"
        check_cmd git pull
    )
    sep 
    lazydev_clone_and_update
else
    print_bold_color "Installing Neovim config..." "cyan"
    check_cmd git clone https://github.com/randomdude16671/neovim-config.git "$NVIM_CONFIG"
    sep 

    print_bold_color "Finished installation of Neovim config.. cloning missing local plugins" "green"
    lazydev_clone_and_update
    sep
fi
