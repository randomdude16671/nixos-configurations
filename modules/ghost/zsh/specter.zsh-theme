# super simple for now, will expand later
autoload -U colors && colors
export PROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %b%{$fg[cyan]%}%~ %{$reset_color%}%B$%b "
