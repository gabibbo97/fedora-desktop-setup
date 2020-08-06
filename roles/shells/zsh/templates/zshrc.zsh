autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

setopt AUTO_CD
setopt AUTO_PUSHD
setopt COMPLETE_ALIASES

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_REDUCE_BLANKS

prompt fade red

command_not_found_handler() { /usr/libexec/pk-command-not-found "$@"; }

{% include 'aliases.sh' %}
{% include 'path.sh' %}

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
ZSH_AUTOSUGGEST_USE_ASYNC='y'

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
