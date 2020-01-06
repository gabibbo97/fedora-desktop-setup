ksm-status() {
  # Exit if not enabled
  if [ "$(cat /sys/kernel/mm/ksm/run)" = "0" ]; then
    echo "KSM is not enabled"
    return
  fi
  # Gather system statistics
  pages_shared=$(cat /sys/kernel/mm/ksm/pages_shared)
  pages_sharing=$(cat /sys/kernel/mm/ksm/pages_sharing)
  page_size=$(getconf PAGESIZE)
  # Exit if no pages have been shared
  if [ "$pages_shared" = "0" ]; then
    echo "No pages are being shared at the moment"
    return
  fi
  # Average sharing
  sharing_ration=$(echo "scale=2; $pages_sharing / $pages_shared" | bc)
  printf 'Each page is shared %d times\n' "$sharing_ratio"
  # Savings
  savings=$(echo "scale=0; $pages_sharing * $page_size" | bc)
  savings_mb=$(( savings / 1024 / 1024 ))
  printf 'Total shared: %d MB\n' "$savings_mb"
}
