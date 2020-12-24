source ~/.bash_aliases
source ~/.bash_functions

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# PROMPT
# https://github.com/sindresorhus/pure
fpath+=('$PWD/functions')
fpath+=('/usr/lib/node_modules/pure-prompt/functions')
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# VI mode
bindkey -v
bindkey "jj" vi-cmd-mode
