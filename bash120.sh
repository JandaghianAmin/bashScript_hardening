#!/bin/bash


check_hosts_deny() {
  if [ -s /etc/hosts.deny ]; then
    echo "/etc/hosts.deny is configured. OK."
  else
    echo "/etc/hosts.deny is not configured. Please configure it."
  fi
}


check_hosts_allow_permissions() {
  if [ $(stat -c "%a" /etc/hosts.allow) -le 644 ]; then
    echo "Permissions for /etc/hosts.allow are correctly set. OK."
  else
    echo "Permissions for /etc/hosts.allow are not correctly set. Please set them to 644 or less."
  fi
}


check_hosts_deny_permissions() {
  if [ $(stat -c "%a" /etc/hosts.deny) -le 644 ]; then
    echo "Permissions for /etc/hosts.deny are correctly set. OK."
  else
    echo "Permissions for /etc/hosts.deny are not correctly set. Please set them to 644 or less."
  fi
}


check_dccp() {
  if ! lsmod | grep -q dccp; then
    echo "DCCP is disabled. OK."
  else
    echo "DCCP is enabled. Please disable it."
  fi
}


check_sctp() {
  if ! lsmod | grep -q sctp; then
    echo "SCTP is disabled. OK."
  else
    echo "SCTP is enabled. Please disable it."
  fi
}


check_rds() {
  if ! lsmod | grep -q rds; then
    echo "RDS is disabled. OK."
  else
    echo "RDS is enabled. Please disable it."
  fi
}


check_tipc() {
  if ! lsmod | grep -q tipc; then
    echo "TIPC is disabled. OK."
  else
    echo "TIPC is enabled. Please disable it."
  fi
}


check_iptables_installed() {
  if rpm -q iptables &> /dev/null; then
    echo "iptables is installed. OK."
  else
    echo "iptables is not installed. Please install it."
  fi
}


check_default_ipv4_firewall_policy() {
  if iptables -L INPUT | grep -q "policy DROP"; then
    echo "Default IPv4 firewall policy is Deny. OK."
  else
    echo "Default IPv4 firewall policy is not Deny. Please set it to Deny."
  fi
}


check_ipv4_loopback_traffic() {
  if iptables -L INPUT -v -n | grep -q "ACCEPT.*lo"; then
    echo "IPv4 loopback traffic is configured. OK."
  else
    echo "IPv4 loopback traffic is not configured. Please configure it."
  fi
}


check_hosts_deny
check_hosts_allow_permissions
check_hosts_deny_permissions
check_dccp
check_sctp
check_rds
check_tipc
check_iptables_installed
check_default_ipv4_firewall_policy
check_ipv4_loopback_traffic
