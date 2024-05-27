#!/bin/bash


enable_time_sync() {
  timedatectl set-ntp true
  echo "Time synchronization has been enabled."
}


configure_chrony() {
  yum install -y chrony
  systemctl enable chronyd
  systemctl start chronyd
  echo "chrony has been configured and started."
}


configure_ntp() {
  yum install -y ntp
  systemctl enable ntpd
  systemctl start ntpd
  echo "ntp has been configured and started."
}


remove_x11() {
  if rpm -q xorg-x11-server-Xorg &> /dev/null; then
    yum remove -y xorg-x11-server-Xorg
    echo "X11 server components have been removed."
  else
    echo "X11 server components are not installed."
  fi
}


remove_avahi() {
  if rpm -q avahi-daemon &> /dev/null; then
    yum remove -y avahi-daemon
    echo "Avahi Server has been removed."
  else
    echo "Avahi Server is not installed."
  fi
}


remove_cups() {
  if rpm -q cups &> /dev/null; then
    yum remove -y cups
    echo "CUPS has been removed."
  else
    echo "CUPS is not installed."
  fi
}


remove_dhcp_server() {
  if rpm -q dhcp &> /dev/null; then
    yum remove -y dhcp
    echo "DHCP Server has been removed."
  else
    echo "DHCP Server is not installed."
  fi
}


remove_ldap_server() {
  if rpm -q openldap-servers &> /dev/null; then
    yum remove -y openldap-servers
    echo "LDAP Server has been removed."
  else
    echo "LDAP Server is not installed."
  fi
}


remove_dns_server() {
  if rpm -q bind &> /dev/null; then
    yum remove -y bind
    echo "DNS Server has been removed."
  else
    echo "DNS Server is not installed."
  fi
}


remove_ftp_server() {
  if rpm -q vsftpd &> /dev/null; then
    yum remove -y vsftpd
    echo "FTP Server has been removed."
  else
    echo "FTP Server is not installed."
  fi
}


enable_time_sync
configure_chrony
configure_ntp
remove_x11
remove_avahi
remove_cups
remove_dhcp_server
remove_ldap_server
remove_dns_server
remove_ftp_server
