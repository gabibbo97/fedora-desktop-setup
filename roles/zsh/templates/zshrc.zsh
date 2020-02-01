# {{ ansible_managed }}

{% include 'oh-my-zsh.zsh' %}

# Aliases
{% for alias, command in zsh_aliases.items() %}
alias {{ alias }}={{ command | quote }}
{% endfor %}
