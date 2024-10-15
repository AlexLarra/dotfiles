source ~/.sh_aliases
source ~/.sh_functions

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# PROMPT
# https://github.com/sindresorhus/pure
fpath+=('$PWD/functions')
fpath+=('/usr/lib/node_modules/pure-prompt/functions')
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:branch color green
prompt pure

# VI mode
bindkey -v
export KEYTIMEOUT=1

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# # Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

# Set cointop config
export COINTOP_CONFIG="~/.cointop_config.toml"

# move through fzf with Tab and no arrow keys
export FZF_DEFAULT_OPTS="--bind tab:down,shift-tab:up"
