#!/bin/sh
set -e # Fail on error
[ -x "$(command -v ansible-playbook)" ] || sudo dnf install -y ansible

# If requested reinitialize migrations to current commit
if [ "$1" = "--migrations-is-current" ]; then
  shift
  echo "Set the migration status to current"
  echo "$(git rev-parse HEAD~1)" > .migration-lock
fi

# Run mitigations
LAST_COMMIT=$(git rev-parse HEAD~1)
if [ -f .migration-lock ]; then
  STARTING_COMMIT=$(cat .migration-lock)
  echo "Starting from $STARTING_COMMIT"
else
  STARTING_COMMIT=$(git rev-list --max-parents=0 HEAD)
  echo "Trying all migrations one after another"
fi
git rev-list "${STARTING_COMMIT}..HEAD" | tac | while read -r commit; do
  if [ -f "migrations/${commit}.sh" ]; then
    printf 'Applying %s\n' "$commit"
    /bin/sh "migrations/${commit}.sh"
  fi
done
echo "$LAST_COMMIT" > .migration-lock
# Run playbook
exec ansible-playbook playbook.yml "$@"
