#!/bin/bash
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

set_sticky_bit() {
  local directories=$(find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)
  if [[ -n "$directories" ]]; then
    for dir in $directories; do
      chmod +t "$dir"
      echo "Sticky bit set on $dir"
    done
  else
    echo "All world-writable directories already have the sticky bit set."
  fi
}

disable_autofs() {
  if chkconfig --list autofs | grep -q "3:on"; then
    chkconfig autofs off
    service autofs stop
    echo "Automounting (autofs) has been disabled."
  else
    echo "Automounting (autofs) is already disabled."
  fi
}

disable_usb() {
  if ! grep -q 'install usb-storage /bin/true' /etc/modprobe.d/usb-storage.conf; then
    echo 'install usb-storage /bin/true' > /etc/modprobe.d/usb-storage.conf
    rmmod usb-storage
    echo "USB storage has been disabled."
  else
    echo "USB storage is already disabled."
  fi
}

configure_package_repositories() {
  if [ -f /etc/yum.repos.d/public-yum-ol6.repo ]; then
    sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/*.repo
    echo "Package repositories have been configured."
  else
    echo "Package repositories configuration file not found."
  fi
}

enable_gpgcheck() {
  if ! grep -q '^gpgcheck=1' /etc/yum.conf; then
    echo 'gpgcheck=1' >> /etc/yum.conf
    echo "gpgcheck has been enabled."
  else
    echo "gpgcheck is already enabled."
  fi
}

set_mount_option_in_fstab "/dev/shm" "nosuid"
set_mount_option_in_fstab "/dev/shm" "noexec"
set_mount_option_in_fstab "/media" "nodev"
set_mount_option_in_fstab "/media" "nosuid"
set_mount_option_in_fstab "/media" "noexec"

mount -o remount /dev/shm
mount -o remount /media

set_sticky_bit

disable_autofs

disable_usb

configure_package_repositories

enable_gpgcheck

