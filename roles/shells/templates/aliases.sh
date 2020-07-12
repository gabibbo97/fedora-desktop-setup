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
