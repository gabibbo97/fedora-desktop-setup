#!/bin/sh
set -e # Fail on error

lsmod | awk '{ print $1 }' | sort | while read -r module; do
  # Skip empty modules
  [ "$(modinfo -p $module | wc -l)" != "0" ] || continue
  # Print module parameters
  echo "$(tput bold)$(tput setaf 2)=== $module ===$(tput sgr0)"
  modinfo -p "$module" | sort
  echo ""
done