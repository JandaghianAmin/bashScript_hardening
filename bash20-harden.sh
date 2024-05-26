#!/bin/bash

add_partition_to_fstab() {
  local mount_point=$1
  if ! grep -q "${mount_point}" /etc/fstab; then
    echo "UUID=$(blkid -s UUID -o value $(findmnt -rn -o SOURCE --target ${mount_point})) ${mount_point} ext4 defaults 0 2" >> /etc/fstab
    echo "${mount_point} added to /etc/fstab."
  else
    echo "${mount_point} is already in /etc/fstab."
  fi
}

set_mount_option_in_fstab() {
  local mount_point=$1
  local option=$2
  if grep -q "${mount_point}" /etc/fstab; then
    sed -i "/${mount_point}/ s/defaults/defaults,${option}/" /etc/fstab
    echo "${option} set for ${mount_point} in /etc/fstab."
  else
    echo "${mount_point} not found in /etc/fstab."
  fi
}

partitions=("/var" "/var/tmp" "/var/log" "/var/log/audit" "/home" "/dev/shm")
mount_options=(
  ["/var/tmp"]="nodev nosuid noexec"
  ["/home"]="nodev"
  ["/dev/shm"]="nodev"
)

for partition in "${partitions[@]}"; do
  add_partition_to_fstab "$partition"
done

for mount_point in "${!mount_options[@]}"; do
  options=${mount_options[$mount_point]}
  for option in $options; do
    set_mount_option_in_fstab "$mount_point" "$option"
  done
done

for mount_point in "${partitions[@]}"; do
  mount -o remount "$mount_point"
done

