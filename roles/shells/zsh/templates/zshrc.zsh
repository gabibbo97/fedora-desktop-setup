source /etc/zshrc

# Completion intialization
autoload -Uz compinit promptinit
compinit
promptinit

# Completion options
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

# Navigation options
setopt AUTO_CD
setopt AUTO_PUSHD
setopt COMPLETE_ALIASES

# History options
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="${HOME}/.zsh_history"
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

command_not_found_handler() { /usr/libexec/pk-command-not-found "$@"; }

# Aliases
{% for alias, alias_cmd in shell_aliases.items() %}
alias {{ alias | quote }}="{{ alias_cmd }}"
{% endfor %}

# Interactive shells
if [ -t 0 ]; then
  # Aliases
  {% for alias, alias_cmd in shell_interactive_aliases.items() %}
  alias {{ alias | quote }}="{{ alias_cmd }}"
  {% endfor %}
  # Vars
  {% for var_name, var_val in shell_interactive_vars.items() %}
  export {{ var_name }}="{{ var_val }}"
  {% endfor %}
fi

# Extra functions

# Extra PATH
export PATH="${PATH}:{{ shell_extra_paths | join(':') }}"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC='y'
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# starship prompt
eval "$(starship init zsh)"
