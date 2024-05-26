#!/bin/bash

disable_filesystem() {
  local fs=$1
  if ! grep -q "^install ${fs} /bin/true" /etc/modprobe.d/${fs}.conf; then
    echo "install ${fs} /bin/true" >> /etc/modprobe.d/${fs}.conf
    echo "Module ${fs} disabled."
  else
    echo "Module ${fs} is already disabled."
  fi
}

filesystems=("freevxfs" "jffs2" "hfs" "hfsplus" "squashfs" "udf")

for fs in "${filesystems[@]}"; do
  disable_filesystem "$fs"
done

configure_tmp() {
  local mount_point="/tmp"
  if ! mount | grep -q "on ${mount_point} type"; then
    echo "/tmp is not mounted. Please mount it manually."
    return
  fi

  if ! grep -q "${mount_point}" /etc/fstab; then
    echo "tmpfs ${mount_point} tmpfs defaults,nodev,nosuid,noexec 0 0" >> /etc/fstab
    mount -o remount,nodev,nosuid,noexec ${mount_point}
    echo "/tmp configured with nodev, nosuid, noexec."
  else
    sed -i "/${mount_point}/ s/defaults.*/defaults,nodev,nosuid,noexec 0 0/" /etc/fstab
    mount -o remount ${mount_point}
    echo "/tmp reconfigured with nodev, nosuid, noexec."
  fi
}

configure_tmp
