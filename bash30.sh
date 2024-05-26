#!/bin/bash

check_mount_option() {
  local mount_point=$1
  local option=$2
  if findmnt -n -o OPTIONS --target "$mount_point" | grep -q "$option"; then
    echo "${mount_point} is mounted with ${option}. OK."
  else
    echo "${mount_point} is not mounted with ${option}. Please set it."
  fi
}

check_sticky_bit() {
  local directories=$(find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)
  if [[ -z "$directories" ]]; then
    echo "All world-writable directories have the sticky bit set. OK."
  else
    echo "The following directories do not have the sticky bit set:"
    echo "$directories"
  fi
}

check_autofs_disabled() {
  if chkconfig --list autofs | grep -q "3:off"; then
    echo "Automounting (autofs) is disabled. OK."
  else
    echo "Automounting (autofs) is enabled. Please disable it."
  fi
}

check_usb_disabled() {
  if grep -q 'install usb-storage /bin/true' /etc/modprobe.d/usb-storage.conf; then
    echo "USB storage is disabled. OK."
  else
    echo "USB storage is not disabled. Please disable it."
  fi
}

check_package_repositories() {
  if [ -f /etc/yum.repos.d/public-yum-ol6.repo ] && grep -q 'enabled=1' /etc/yum.repos.d/*.repo; then
    echo "Package repositories are configured. OK."
  else
    echo "Package repositories are not properly configured. Please configure them."
  fi
}

check_gpgcheck() {
  if grep -q '^gpgcheck=1' /etc/yum.conf; then
    echo "gpgcheck is enabled. OK."
  else
    echo "gpgcheck is not enabled. Please enable it."
  fi
}

check_mount_option "/dev/shm" "nosuid"
check_mount_option "/dev/shm" "noexec"
check_mount_option "/media" "nodev"
check_mount_option "/media" "nosuid"
check_mount_option "/media" "noexec"

check_sticky_bit

check_autofs_disabled

check_usb_disabled

check_package_repositories

check_gpgcheck

