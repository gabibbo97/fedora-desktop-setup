function known-hosts-remove() {
  # Exit if not found
  if ! [ -f ~/.ssh/known_hosts ]; then
    echo "~/.ssh/known_hosts not found" > /dev/stderr
    exit 1
  fi
  # Replace
  TMPFILE=$(mktemp)

  grep -v "$1" < ~/.ssh/known_hosts > "$TMPFILE"

  if ! cmp ~/.ssh/known_hosts "$TMPFILE"; then
    mv "$TMPFILE" ~/.ssh/known_hosts
    echo "Line removed"
  fi

  rm -f "$TMPFILE"
  unset TMPFILE
  # Recall function
  shift
  if [ $# -gt 0 ]; then $0 "$@"; fi
}