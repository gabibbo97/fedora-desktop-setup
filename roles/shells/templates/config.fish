# Aliases
{% for alias, command in shell_aliases.items() %}
alias {{ alias }}={{ command | quote }}
{% endfor %}
# Prompt
set fish_greeting
