# PATH
# Path
{% for dir in shell_path_extensions %}
if test -d "{{ dir }}"
	set PATH "{{ dir }}" $PATH
end
{% endfor %}
# Aliases
{% for alias, command in shell_aliases.items() %}
alias {{ alias }}={{ command | quote }}
{% endfor %}
# Prompt
set fish_greeting
