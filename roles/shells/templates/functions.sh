
# Extra functions
## Container wrappers
__container_command_wrap() {
  podman run --rm -i \
    --network=host \
    --privileged=true \
    --pid=host \
    --userns=host \
    --uts=host \
    --security-opt label=disable \
    --volume "/:/host" \
    --workdir "/host/${PWD}" \
    "$@"
}
{% for cmd, opts in shell_containers.items() %}
{{ cmd }}() { __container_command_wrap {{ opts['extra_args'] | default([]) | join(' ') }} {{ opts['image'] }} "$@"; }
{% endfor %}
