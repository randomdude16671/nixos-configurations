setopt PROMPT_SUBST
autoload -U colors && colors

branch() {
  # Check if inside a Git repo
  if git rev-parse --git-dir > /dev/null 2>&1; then
    # Print branch icon + branch name
    echo " $(git rev-parse --abbrev-ref HEAD)"
  else
    echo ""
  fi
}

PROMPT='%F{yellow}%n%f@%F{blue}%m%f:%F{blue}%~%f %# '
RPROMPT='%F{red}$(branch)%f'
