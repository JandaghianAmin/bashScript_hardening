#!/bin/bash


configure_hosts_deny() {
  echo "ALL: ALL" >> /etc/hosts.deny
  echo "/etc/hosts.deny has been configured."
}


set_hosts_allow_permissions() {
  chmod 644 /etc/hosts.allow
  echo "Permissions for /etc/hosts.allow have been set to 644."
}


set_hosts_deny_permissions() {
  chmod 644 /etc/hosts.deny
  echo "Permissions for /etc/hosts.deny have been set to 644."
}


disable_dccp() {
  echo "install dccp /bin/true" >> /etc/modprobe.d/disable_dccp.conf
  rmmod dccp &> /dev/null
  echo "DCCP has been disabled."
}


disable_sctp() {
  echo "install sctp /bin/true" >> /etc/modprobe.d/disable_sctp.conf
  rmmod sctp &> /dev/null
  echo "SCTP has been disabled."
}


disable_rds() {
  echo "install rds /bin/true" >> /etc/modprobe.d/disable_rds.conf
  rmmod rds &> /dev/null
  echo "RDS has been disabled."
}


disable_tipc() {
  echo "install tipc /bin/true" >> /etc/modprobe.d/disable_tipc.conf
  rmmod tipc &> /dev/null
  echo "TIPC has been disabled."
}


install_iptables() {
  if ! rpm -q iptables &> /dev/null; then
    yum install -y iptables
    echo "iptables has been installed."
  else
    echo "iptables is already installed."
  fi
}


set_default_ipv4_firewall_policy() {
  iptables -P INPUT DROP
  iptables -P FORWARD DROP
  iptables -P OUTPUT ACCEPT
  service iptables save
  echo "Default IPv4 firewall policy has been set to Deny."
}


configure_ipv4_loopback_traffic() {
  iptables -A INPUT -i lo -j ACCEPT
  iptables -A OUTPUT -o lo -j ACCEPT
  service iptables save
  echo "IPv4 loopback traffic has been configured."
}


configure_hosts_deny
set_hosts_allow_permissions
set_hosts_deny_permissions
disable_dccp
disable_sctp
disable_rds
disable_tipc
install_iptables
set_default_ipv4_firewall_policy
configure_ipv4_loopback_traffic
