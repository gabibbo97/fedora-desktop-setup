#!/bin/sh
set -e # Fail on error

# Utils

#
# Run a given command as root
#
asRoot() {
  if [ $EUID -eq 0 ]; then
    # Already root
    eval "$@"
  else
    # Escalate privileges
    eval sudo "$@"
  fi
}

#
# Uninstall packages if needed
#
uninstallPackage() {
  # Check if installed
  if dnf list installed "$1" > /dev/null 2>&1; then
    asRoot dnf remove -y "$1"
  else
    echo "Package $1 is already absent"
  fi
  # Call this function again
  if [ $# -gt 1 ]; then
    shift;
    uninstallPackage "$@"
  fi
}