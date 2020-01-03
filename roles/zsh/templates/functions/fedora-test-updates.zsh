fedora-test-updates() {
  [ -x "$(command -v fedora-easy-karma)" ] || sudo dnf install -y fedora-easy-karma
  sudo dnf update --skip-broken --enablerepo="*-testing" && fedora-easy-karma
}