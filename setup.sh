#!/bin/sh
set -e # Fail on error

# Install Ansible
if ! [ -x "$(command -v ansible)" ]; then
    sudo dnf install -y ansible
fi

# Run playbook
exec ansible-playbook playbook.yml "$@"
