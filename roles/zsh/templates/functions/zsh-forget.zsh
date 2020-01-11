zsh-forget() {
  # Exit if argument has not been provided
  if [ -z "$1" ]; then
    echo "No argument provided" && exit 1
  fi

  TMPHIST=$(mktemp)

  while [ $# -gt 0 ]; do
    FILTER_COMMAND="$FILTER_COMMAND | grep -v $1"
    shift
  done

  for historyFile in $HISTFILE ~/.bash_history ~/.zsh_history; do
    if ! [ -f "$historyFile" ]; then continue; fi
    COMMAND="cat $historyFile $FILTER_COMMAND > $TMPHIST"
    eval "$COMMAND"
    cp "$TMPHIST" "$historyFile"
  done

  rm -f "$TMPHIST"
}

zsh-forget-default() {
  zsh-forget \
    'ACCESS_KEY' \
    'SECRET_KEY' \
    'MINIO_ACCESS_KEY' \
    'MINIO_ACCESS_KEY_OLD' \
    'MINIO_SECRET_KEY' \
    'MINIO_SECRET_KEY_OLD' \
    'X-Vault-Token' \
    'password' \
    'token' \
    'zsh-forget'
}
