helm() {
  unfunction "$0"
  source <(helm completion zsh)
  "$0" "$@"
}
