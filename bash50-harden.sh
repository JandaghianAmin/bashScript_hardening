#!/bin/bash

disable_prelink() {
  if rpm -q prelink &> /dev/null; then
    yum remove -y prelink
    echo "prelink has been uninstalled."
  else
    echo "prelink is already uninstalled."
  fi
}

install_selinux() {
  if ! rpm -q libselinux &> /dev/null; then
    yum install -y libselinux libselinux-utils policycoreutils
    echo "SELinux has been installed."
  else
    echo "SELinux is already installed."
  fi
}

enable_selinux_boot_loader() {
  if grep -q "selinux=0" /boot/grub/grub.conf || grep -q "enforcing=0" /boot/grub/grub.conf; then
    sed -i 's/selinux=0//' /boot/grub/grub.conf
    sed -i 's/enforcing=0//' /boot/grub/grub.conf
    echo "SELinux has been enabled in the boot loader configuration."
  else
    echo "SELinux is already enabled in the boot loader configuration."
  fi
}

configure_selinux_policy() {
  if [ "$(sestatus | grep "Loaded policy name" | awk '{print $4}')" != "targeted" ]; then
    setsebool -P targeted 1
    echo "SELinux policy has been configured."
  else
    echo "SELinux policy is already configured."
  fi
}

set_selinux_enforcing() {
  if [ "$(sestatus | grep "Current mode" | awk '{print $3}')" != "enforcing" ]; then
    setenforce 1
    sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
    echo "SELinux mode has been set to enforcing."
  else
    echo "SELinux mode is already set to enforcing."
  fi
}

enable_selinux_running() {
  if ! sestatus | grep -q "SELinux status: enabled"; then
    setenforce 1
    echo "SELinux has been enabled."
  else
    echo "SELinux is already running."
  fi
}

confine_unconfined_daemons() {
  if ps -eZ | egrep "initrc" | egrep -q -v "tr|ps|egrep"; then
    for daemon in $(ps -eZ | egrep "initrc" | egrep -v "tr|ps|egrep" | awk '{print $NF}'); do
      semanage permissive -d $daemon
      echo "$daemon has been confined."
    done
  else
    echo "No unconfined daemons found."
  fi
}

remove_setroubleshoot() {
  if rpm -q setroubleshoot &> /dev/null; then
    yum remove -y setroubleshoot
    echo "SETroubleshoot has been uninstalled."
  else
    echo "SETroubleshoot is already uninstalled."
  fi
}

remove_mcstrans() {
  if rpm -q mcstrans &> /dev/null; then
    yum remove -y mcstrans
    echo "mcstrans has been uninstalled."
  else
    echo "mcstrans is already uninstalled."
  fi
}

configure_motd() {
  echo "Authorized uses only. All activity may be monitored and reported." > /etc/motd
  echo "Message of the day has been configured."
}

disable_prelink
install_selinux
enable_selinux_boot_loader
configure_selinux_policy
set_selinux_enforcing
enable_selinux_running
confine_unconfined_daemons
remove_setroubleshoot
remove_mcstrans
configure_motd

