#!/bin/bash

check_gpg_keys() {
  if rpm -qa gpg-pubkey* &> /dev/null; then
    echo "GPG keys are configured. OK."
  else
    echo "GPG keys are not configured. Please configure them."
  fi
}

check_aide_installed() {
  if rpm -q aide &> /dev/null; then
    echo "AIDE is installed. OK."
  else
    echo "AIDE is not installed. Please install it."
  fi
}

check_aide_cron() {
  if crontab -l | grep -q "/usr/sbin/aide --check"; then
    echo "AIDE file integrity checks are scheduled. OK."
  else
    echo "AIDE file integrity checks are not scheduled. Please schedule them."
  fi
}

check_grub_permissions() {
  if [ -f /boot/grub/grub.conf ]; then
    perms=$(stat -c "%a" /boot/grub/grub.conf)
    if [ "$perms" -eq 600 ]; then
      echo "Bootloader configuration file permissions are set correctly. OK."
    else
      echo "Bootloader configuration file permissions are not set correctly. Please set them."
    fi
  else
    echo "Bootloader configuration file not found. Please check your bootloader configuration."
  fi
}

check_grub_password() {
  if grep -q "password" /boot/grub/grub.conf; then
    echo "Bootloader password is set. OK."
  else
    echo "Bootloader password is not set. Please set it."
  fi
}

check_single_user_auth() {
  if grep -q "SINGLE=/sbin/sulogin" /etc/sysconfig/init; then
    echo "Authentication for single user mode is configured. OK."
  else
    echo "Authentication for single user mode is not configured. Please configure it."
  fi
}

check_interactive_boot() {
  if grep -q "^PROMPT=no" /etc/sysconfig/init; then
    echo "Interactive boot is disabled. OK."
  else
    echo "Interactive boot is not disabled. Please disable it."
  fi
}

check_core_dumps() {
  if grep -q "hard core 0" /etc/security/limits.conf; then
    echo "Core dumps are restricted. OK."
  else
    echo "Core dumps are not restricted. Please restrict them."
  fi
}

check_xd_nx() {
  if dmesg | grep -q "NX (Execute Disable) protection: active"; then
    echo "XD/NX support is enabled. OK."
  else
    echo "XD/NX support is not enabled. Please enable it."
  fi
}

check_aslr() {
  if [ "$(sysctl -n kernel.randomize_va_space)" -eq 2 ]; then
    echo "ASLR is enabled. OK."
  else
    echo "ASLR is not enabled. Please enable it."
  fi
}

check_gpg_keys
check_aide_installed
check_aide_cron
check_grub_permissions
check_grub_password
check_single_user_auth
check_interactive_boot
check_core_dumps
check_xd_nx
check_aslr

