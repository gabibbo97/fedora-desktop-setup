# {{ ansible_managed }}

# Add autoload path
fpath=($ZSH_CUSTOM/plugins/g4b1bb097/functions $fpath)

# Autoload functions
autoload -Uz \
  fedora-test-updates \
  kexec-reboot \
  known-hosts-remove \
  ksm-status \
  zsh-forget \
  zsh-update-plugins
