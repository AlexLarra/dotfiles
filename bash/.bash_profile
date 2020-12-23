# provide __git_ps1 in Arch
source /usr/share/git/completion/git-prompt.sh

set -o vi

bind 'set completion-ignore-case on'
shopt -s cdspell
complete -d cd

function git_dirty
{
  local status=$(git status --porcelain 2> /dev/null)

  if [[ "$status" != "" ]]; then
    echo '* '
  else
    echo ''
  fi
}

# Regular colors
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"

# Emphasized (bolded) colors
BRED="\[\033[1;31m\]"
BGREEN="\[\033[1;32m\]"
BYELLOW="\[\033[1;33m\]"
BBLUE="\[\033[1;34m\]"
BCYAN="\[\033[1;36m\]"
BWHITE="\[\033[1;37m\]"

# Prompt style
PS1="$BBLUE\W$BGREEN\$(__git_ps1)$BRED\$(git_dirty)$WHITE\$ "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
