minikube() {
  unfunction "$0"
  source <(minikube completion zsh)
  "$0" "$@"
}
minikube_attach_disk() {
  # Check if minikube is running
  if ! sudo virsh list --all | grep 'minikube' | grep -q 'running'; then
    echo 'Minikube is not running'
  fi
  # Find disk
  DISK_INDEX=1
  DISK_PATH="$HOME/minikube-disk${DISK_INDEX}.qcow2"
  DISK_TARGET='vdb'
  while [ -f "$DISK_PATH" ]; do
    DISK_INDEX=$(( DISK_INDEX + 1 ))
    DISK_PATH="$HOME/minikube-disk${DISK_INDEX}.qcow2"
    DISK_TARGET="vd$(echo $DISK_INDEX | tr '1-9' 'b-z')"
  done
  # Create disk
  rm -f "$DISK_PATH"
  qemu-img create -f qcow2 "$DISK_PATH" 50G
  chattr +C "$DISK_PATH"
  # Attach disk
  sudo virsh attach-disk \
    --source "$DISK_PATH" \
    --domain minikube \
    --targetbus virtio \
    --subdriver qcow2 \
    --target "$DISK_TARGET" \
    --config
  # Restart minikube
  minikube stop && minikube start
}
minikube_detach_disks() {
  rm -f "$HOME"/minikube-disk*.qcow2
}
