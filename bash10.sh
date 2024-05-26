#!/bin/bash

check_disabled_filesystem() {
  local fs=$1
  if lsmod | grep -q "^${fs}"; then
    echo "Module ${fs} is loaded. Please disable it."
  else
    echo "Module ${fs} is not loaded. OK."
  fi
}

filesystems=("freevxfs" "jffs2" "hfs" "hfsplus" "squashfs" "udf")

for fs in "${filesystems[@]}"; do
  check_disabled_filesystem "$fs"
done

check_tmp_mount_options() {
  local mount_point="/tmp"
  local options=$(findmnt -n -o OPTIONS --target "$mount_point")

  if [[ "$options" == *nodev* ]]; then
    echo "/tmp is mounted with nodev. OK."
  else
    echo "/tmp is not mounted with nodev. Please set it."
  fi

  if [[ "$options" == *nosuid* ]]; then
    echo "/tmp is mounted with nosuid. OK."
  else
    echo "/tmp is not mounted with nosuid. Please set it."
  fi

  if [[ "$options" == *noexec* ]]; then
    echo "/tmp is mounted with noexec. OK."
  else
    echo "/tmp is not mounted with noexec. Please set it."
  fi
}

# بررسی /tmp
check_tmp_mount_options

