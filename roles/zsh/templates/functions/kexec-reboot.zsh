kexec-reboot() {
  # Check kexec
  if ! [ -x "$(command -v kexec)" ]; then
    echo 'kexec not available' > /dev/stderr && exit 1
  fi
  # Check root
  if [ "$(id -u)" != "0" ]; then
    echo 'Please run as root' > /dev/stderr && exit 1
  fi
  # Find initrd
  INITRD=$(find /boot -maxdepth 1 -type f -name '*.img' -not -name '*rescue*' | sort - | tail -n 1)
  if [ -z "$INITRD" ]; then
    echo 'Initrd not found' > /dev/stderr && exit 1
  fi
  # Find kernel image
  KERNEL=$(find /boot -maxdepth 1 -type f -name 'vmlinuz*' -not -name '*rescue*' | sort - | tail -n 1)
  if [ -z "$KERNEL" ]; then
    echo 'Kernel not found' > /dev/stderr && exit 1
  fi
  # Load Kexec
  kexec --reuse-cmdline \
    "--initrd=$INITRD" \
    "$KERNEL"
  # Perform Kexec
  systemctl kexec
}
