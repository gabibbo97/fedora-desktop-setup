# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
  export PATH
fi

# Ignore commands starting with a space
HISTCONTROL=ignorespace

# Size of the history file
HISTFILESIZE=10000
HISTSIZE=10000

# Readline options
set colored-completion-prefix On
set colored-stats On

# Shell options
shopt -s \
  autocd \
  cdspell \
  histappend

# Super minimal
__prompt_command() {
  local EXIT="$?"
  local PROMPT=" \[\e[33m\]\W\[\e[m\] "

  if [[ $EXIT -ne 0 ]]; then
      local RED="\[\e[0;31m\]"
      local RESET="\e[0m"
      PROMPT="${PROMPT}${RED}${EXIT}${RESET} "
  fi
  export PS1="${PROMPT}"
}
PROMPT_COMMAND=__prompt_command

{% include 'aliases.sh' %}
{% include 'path.sh' %}
