#!/bin/bash

check_prelink_disabled() {
  if rpm -q prelink &> /dev/null; then
    echo "prelink is installed. Please uninstall it."
  else
    echo "prelink is not installed. OK."
  fi
}

check_selinux_installed() {
  if rpm -q libselinux &> /dev/null; then
    echo "SELinux is installed. OK."
  else
    echo "SELinux is not installed. Please install it."
  fi
}

check_selinux_boot_loader() {
  if grep -q "selinux=0" /boot/grub/grub.conf || grep -q "enforcing=0" /boot/grub/grub.conf; then
    echo "SELinux is disabled in the boot loader configuration. Please enable it."
  else
    echo "SELinux is enabled in the boot loader configuration. OK."
  fi
}

check_selinux_policy() {
  policy=$(sestatus | grep "Loaded policy name" | awk '{print $4}')
  if [ "$policy" == "targeted" ]; then
    echo "SELinux policy is configured. OK."
  else
    echo "SELinux policy is not configured. Please configure it."
  fi
}

check_selinux_mode() {
  mode=$(sestatus | grep "Current mode" | awk '{print $3}')
  if [ "$mode" == "enforcing" ] || [ "$mode" == "permissive" ]; then
    echo "SELinux mode is $mode. OK."
  else
    echo "SELinux mode is not set to enforcing or permissive. Please set it."
  fi
}

check_selinux_running() {
  if sestatus | grep -q "SELinux status: enabled"; then
    echo "SELinux is running. OK."
  else
    echo "SELinux is not running. Please enable it."
  fi
}

check_unconfined_daemons() {
  if ps -eZ | egrep "initrc" | egrep -q -v "tr|ps|egrep"; then
    echo "There are unconfined daemons. Please confine them."
  else
    echo "No unconfined daemons found. OK."
  fi
}

check_setroubleshoot_not_installed() {
  if rpm -q setroubleshoot &> /dev/null; then
    echo "SETroubleshoot is installed. Please uninstall it."
  else
    echo "SETroubleshoot is not installed. OK."
  fi
}

check_mcstrans_not_installed() {
  if rpm -q mcstrans &> /dev/null; then
    echo "mcstrans is installed. Please uninstall it."
  else
    echo "mcstrans is not installed. OK."
  fi
}

check_motd() {
  if grep -q "Authorized uses only. All activity may be monitored and reported." /etc/motd; then
    echo "Message of the day is configured correctly. OK."
  else
    echo "Message of the day is not configured correctly. Please configure it."
  fi
}

check_prelink_disabled
check_selinux_installed
check_selinux_boot_loader
check_selinux_policy
check_selinux_mode
check_selinux_running
check_unconfined_daemons
check_setroubleshoot_not_installed
check_mcstrans_not_installed
check_motd

