#!/bin/sh
set -e # Fail on error
[ -x "$(command -v ansible-playbook)" ] || sudo dnf install -y ansible
exec ansible-playbook playbook.yml "$@"
