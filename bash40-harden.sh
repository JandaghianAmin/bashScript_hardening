#!/bin/bash

configure_gpg_keys() {
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY*
  echo "GPG keys have been configured."
}

install_aide() {
  if ! rpm -q aide &> /dev/null; then
    yum install -y aide
    aide --init
    mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
    echo "AIDE has been installed and initialized."
  else
    echo "AIDE is already installed."
  fi
}

schedule_aide() {
  if ! crontab -l | grep -q "/usr/sbin/aide --check"; then
    (crontab -l 2>/dev/null; echo "0 5 * * * /usr/sbin/aide --check") | crontab -
    echo "AIDE file integrity checks have been scheduled."
  else
    echo "AIDE file integrity checks are already scheduled."
  fi
}

configure_grub_permissions() {
  chmod 600 /boot/grub/grub.conf
  echo "Bootloader configuration file permissions have been set."
}

set_grub_password() {
  if ! grep -q "password" /boot/grub/grub.conf; then
    echo "password --md5 $(grub-md5-crypt)" >> /boot/grub/grub.conf
    echo "Bootloader password has been set."
  else
    echo "Bootloader password is already set."
  fi
}

configure_single_user_auth() {
  if ! grep -q "SINGLE=/sbin/sulogin" /etc/sysconfig/init; then
    echo 'SINGLE=/sbin/sulogin' >> /etc/sysconfig/init
    echo "Authentication for single user mode has been configured."
  else
    echo "Authentication for single user mode is already configured."
  fi
}

disable_interactive_boot() {
  if ! grep -q "^PROMPT=no" /etc/sysconfig/init; then
    sed -i 's/^PROMPT=yes/PROMPT=no/' /etc/sysconfig/init
    echo "Interactive boot has been disabled."
  else
    echo "Interactive boot is already disabled."
  fi
}

restrict_core_dumps() {
  if ! grep -q "hard core 0" /etc/security/limits.conf; then
    echo '* hard core 0' >> /etc/security/limits.conf
    echo "Core dumps have been restricted."
  else
    echo "Core dumps are already restricted."
  fi
}

enable_xd_nx() {
  if ! dmesg | grep -q "NX (Execute Disable) protection: active"; then
    echo "Please enable XD/NX support in the BIOS."
  else
    echo "XD/NX support is already enabled."
  fi
}

enable_aslr() {
  if [ "$(sysctl -n kernel.randomize_va_space)" -ne 2 ]; then
    sysctl -w kernel.randomize_va_space=2
    echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
    echo "ASLR has been enabled."
  else
    echo "ASLR is already enabled."
  fi
}

configure_gpg_keys
install_aide
schedule_aide
configure_grub_permissions
set_grub_password
configure_single_user_auth
disable_interactive_boot
restrict_core_dumps
enable_xd_nx
enable_aslr

