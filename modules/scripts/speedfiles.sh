#!/usr/bin/env bash

search_with_zoxdie() {
    if [ -z "$1" ]; then
        file="$(fd --type f -I -H -E .git -E .git-crypt -E .cache -E .backup | fzf --height=70% --preview='bat -n --color=always --line-range :500 {}' --border)"
        if [ -n "$file" ]; then
            nvim "$file"
        fi
    else
        lines=$(zoxide query -l | xargs -I {} fd --type f -I -H -E .git -E .git-crypt -E .cache -E .backup -E .vscode "$1" {} | fzf --no-sort)
        line_count="$(echo "$lines" | wc -l | xargs)"

        if [ -n "$lines" ] && [ "$line_count" -eq 1 ]; then
            file="$lines"
            nvim "$file"
        elif [ -n "$lines" ]; then
            file=$(echo "$lines" | fzf --query="$1" --height=70% --preview='bat -n --color=always --line-range :500 {}')
            if [ -n "$file" ]; then
                nvim "$file"
            fi
        else
            echo "No matches found." >&2
        fi
    fi
}

search_with_zoxdie "$@"
