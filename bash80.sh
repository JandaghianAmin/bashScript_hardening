#!/bin/bash


check_time_sync() {
  if timedatectl status | grep -q "NTP synchronized: yes"; then
    echo "Time synchronization is enabled. OK."
  else
    echo "Time synchronization is not enabled. Please enable it."
  fi
}


check_chrony() {
  if systemctl is-enabled chronyd &> /dev/null; then
    echo "chrony is configured. OK."
  else
    echo "chrony is not configured. Please configure it."
  fi
}


check_ntp() {
  if systemctl is-enabled ntpd &> /dev/null; then
    echo "ntp is configured. OK."
  else
    echo "ntp is not configured. Please configure it."
  fi
}


check_x11() {
  if rpm -q xorg-x11-server-Xorg &> /dev/null; then
    echo "X11 server components are installed. Please remove them."
  else
    echo "X11 server components are not installed. OK."
  fi
}


check_avahi() {
  if rpm -q avahi-daemon &> /dev/null; then
    echo "Avahi Server is installed. Please remove it."
  else
    echo "Avahi Server is not installed. OK."
  fi
}


check_cups() {
  if rpm -q cups &> /dev/null; then
    echo "CUPS is installed. Please remove it."
  else
    echo "CUPS is not installed. OK."
  fi
}


check_dhcp_server() {
  if rpm -q dhcp &> /dev/null; then
    echo "DHCP Server is installed. Please remove it."
  else
    echo "DHCP Server is not installed. OK."
  fi
}


check_ldap_server() {
  if rpm -q openldap-servers &> /dev/null; then
    echo "LDAP Server is installed. Please remove it."
  else
    echo "LDAP Server is not installed. OK."
  fi
}


check_dns_server() {
  if rpm -q bind &> /dev/null; then
    echo "DNS Server is installed. Please remove it."
  else
    echo "DNS Server is not installed. OK."
  fi
}


check_ftp_server() {
  if rpm -q vsftpd &> /dev/null; then
    echo "FTP Server is installed. Please remove it."
  else
    echo "FTP Server is not installed. OK."
  fi
}


check_time_sync
check_chrony
check_ntp
check_x11
check_avahi
check_cups
check_dhcp_server
check_ldap_server
check_dns_server
check_ftp_server
