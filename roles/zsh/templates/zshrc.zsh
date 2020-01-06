# {{ ansible_managed }}

{% include 'oh-my-zsh.zsh' %}

# Functions
{% include 'functions/fedora-test-updates.zsh' %}

{% include 'functions/ksm-status.zsh' %}

{% include 'functions/zsh-update-plugins.zsh' %}

# Aliases
{% for alias, command in zsh_aliases.items() %}
alias {{ alias }}={{ command | quote }}
{% endfor %}
