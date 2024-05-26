#!/bin/bash

check_separate_partition() {
  local mount_point=$1
  if findmnt -rn -o TARGET | grep -q "^${mount_point}$"; then
    echo "${mount_point} has a separate partition. OK."
  else
    echo "${mount_point} does not have a separate partition. Please set it."
  fi
}

check_mount_option() {
  local mount_point=$1
  local option=$2
  if findmnt -n -o OPTIONS --target "$mount_point" | grep -q "$option"; then
    echo "${mount_point} is mounted with ${option}. OK."
  else
    echo "${mount_point} is not mounted with ${option}. Please set it."
  fi
}

partitions=("/var" "/var/tmp" "/var/log" "/var/log/audit" "/home" "/dev/shm")
mount_options=(
  ["/var/tmp"]="nodev nosuid noexec"
  ["/home"]="nodev"
  ["/dev/shm"]="nodev"
)

for partition in "${partitions[@]}"; do
  check_separate_partition "$partition"
done

for mount_point in "${!mount_options[@]}"; do
  options=${mount_options[$mount_point]}
  for option in $options; do
    check_mount_option "$mount_point" "$option"
  done
done

