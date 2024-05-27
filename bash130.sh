#!/bin/bash


check_ipv4_outbound_established_connections() {
  if iptables -L OUTPUT -v -n | grep -q "state NEW,ESTABLISHED"; then
    echo "IPv4 outbound and established connections are configured. OK."
  else
    echo "IPv4 outbound and established connections are not properly configured."
  fi
}


check_ipv4_firewall_rules() {
  open_ports=$(netstat -tuln | grep '^tcp' | awk '{print $4}' | sed 's/.*://')
  for port in $open_ports; do
    if ! iptables -L INPUT -v -n | grep -q "$port"; then
      echo "Firewall rule for port $port is not configured. Please configure it."
    else
      echo "Firewall rule for port $port is configured. OK."
    fi
  done
}


check_default_ipv6_firewall_policy() {
  if ip6tables -L INPUT | grep -q "policy DROP"; then
    echo "Default IPv6 firewall policy is Deny. OK."
  else
    echo "Default IPv6 firewall policy is not Deny. Please set it to Deny."
  fi
}


check_ipv6_loopback_traffic() {
  if ip6tables -L INPUT -v -n | grep -q "ACCEPT.*lo"; then
    echo "IPv6 loopback traffic is configured. OK."
  else
    echo "IPv6 loopback traffic is not configured. Please configure it."
  fi
}


check_ipv6_outbound_established_connections() {
  if ip6tables -L OUTPUT -v -n | grep -q "state NEW,ESTABLISHED"; then
    echo "IPv6 outbound and established connections are configured. OK."
  else
    echo "IPv6 outbound and established connections are not properly configured."
  fi
}


check_ipv6_firewall_rules() {
  open_ports=$(netstat -tuln | grep '^tcp6' | awk '{print $4}' | sed 's/.*://')
  for port in $open_ports; do
    if ! ip6tables -L INPUT -v -n | grep -q "$port"; then
      echo "IPv6 firewall rule for port $port is not configured. Please configure it."
    else
      echo "IPv6 firewall rule for port $port is configured. OK."
    fi
  done
}


check_auditd_installed() {
  if rpm -q audit &> /dev/null; then
    echo "auditd is installed. OK."
  else
    echo "auditd is not installed. Please install it."
  fi
}


check_augenrules_enabled() {
  if grep -q '^USE_AUGENRULES="yes"' /etc/sysconfig/auditd; then
    echo "augenrules is enabled. OK."
  else
    echo "augenrules is not enabled. Please enable it in /etc/sysconfig/auditd."
  fi
}


check_auditd_service_active() {
  if systemctl is-active auditd &> /dev/null; then
    echo "auditd service is active. OK."
  else
    echo "auditd service is not active. Please activate it."
  fi
}


check_audit_for_prior_processes() {
  if grep -q 'audit=1' /proc/cmdline; then
    echo "Audit for processes prior to auditd is enabled. OK."
  else
    echo "Audit for processes prior to auditd is not enabled. Please add 'audit=1' to kernel parameters."
  fi
}


check_ipv4_outbound_established_connections
check_ipv4_firewall_rules
check_default_ipv6_firewall_policy
check_ipv6_loopback_traffic
check_ipv6_outbound_established_connections
check_ipv6_firewall_rules
check_auditd_installed
check_augenrules_enabled
check_auditd_service_active
check_audit_for_prior_processes
