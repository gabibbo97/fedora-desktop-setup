#!/bin/sh
set -e # Fail on error
[ -x "$(command -v ansible-playbook)" ] || sudo dnf install -y ansible

# Run mitigations
CURR_COMMIT=$(git rev-parse HEAD)
LAST_COMMIT=$(git rev-parse HEAD~1)
if [ -f "migrations/${LAST_COMMIT}.sh" ]; then
  printf 'Migrating %s -> %s\n' \
    "$LAST_COMMIT" \
    "$CURR_COMMIT"
  /bin/sh "migrations/${LAST_COMMIT}.sh"
fi
# Run playbook
exec ansible-playbook playbook.yml "$@"
