#!/usr/bin/env python3
from pathlib import Path
import re

fstab = Path('/etc/fstab')
fstab_lines = [ x.strip() for x in open('/etc/fstab', 'r').readlines() ]

new_lines = []

# Parse and add
for line in fstab_lines:
  components = line.split()
  if len(components) == 6 and components[2] == 'btrfs':
    # BTRFS
    btrfs_opts = components[3].split(',')
    generic_opts = [ 'compress=zstd:4' ]

    new_opts = set(btrfs_opts)
    for opt in generic_opts:
      new_opts.add(opt)

    components[3] = ','.join(sorted(new_opts))

    new_lines.append('\t'.join(components))
  else:
    new_lines.append(line)

# Format
columns_count = max([ len(x.split()) for x in new_lines if not x.startswith('#') ])
columns_width = []
for column in range(columns_count):
  max_width = max([ len(x.split()[column]) for x in new_lines if not x.startswith('#') and len(x.split()) == columns_count ])
  columns_width.append(max_width)

# Print
for line in new_lines:
  if line.startswith('#') or len(line.split()) != columns_count:
    print(line)
  else:
    components = line.split()
    for column in range(columns_count):
      print(components[column].ljust(columns_width[column]), end = '')
      print(' ', end = '')
    print('')
