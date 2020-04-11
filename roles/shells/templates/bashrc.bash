# Fedora setup
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi
# Path
{% for dir in shell_path_extensions %}
if [ -d "{{ dir }}" ]; then
	export PATH="{{ dir }}:$PATH"
fi
{% endfor %}
# Aliases
{% for alias, command in shell_aliases.items() %}
alias {{ alias }}={{ command | quote }}
{% endfor %}
# Completions
{{ lookup('pipe','helm completion bash') }}
{{ lookup('pipe','kubectl completion bash') }}
{{ lookup('pipe','minikube completion bash') }}
# Prompt
function nonzero_return() {
	local RETVAL=$?
	[ $RETVAL -ne 0 ] && echo " $RETVAL"
}
export PS1="\[\e[32m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\] \[\e[33m\]\w\[\e[m\]\[\e[31m\]\`nonzero_return\`\[\e[m\] \\$ "
