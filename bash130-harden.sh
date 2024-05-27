#!/bin/bash


configure_ipv4_outbound_established_connections() {
  iptables -A OUTPUT -m state --state NEW,ESTABLISHED -j ACCEPT
  echo "Configured IPv4 outbound and established connections."
}


configure_ipv4_firewall_rules() {
  open_ports=$(netstat -tuln | grep '^tcp' | awk '{print $4}' | sed 's/.*://')
  for port in $open_ports; do
    iptables -A INPUT -p tcp --dport $port -j ACCEPT
  done
  echo "Configured IPv4 firewall rules for all open ports."
}


set_default_ipv6_firewall_policy() {
  ip6tables -P INPUT DROP
  ip6tables -P FORWARD DROP
  ip6tables -P OUTPUT ACCEPT
  service ip6tables save
  echo "Set default IPv6 firewall policy to Deny."
}


configure_ipv6_loopback_traffic() {
  ip6tables -A INPUT -i lo -j ACCEPT
  ip6tables -A OUTPUT -o lo -j ACCEPT
  service ip6tables save
  echo "Configured IPv6 loopback traffic."
}


configure_ipv6_outbound_established_connections() {
  ip6tables -A OUTPUT -m state --state NEW,ESTABLISHED -j ACCEPT
  echo "Configured IPv6 outbound and established connections."
}


configure_ipv6_firewall_rules() {
  open_ports=$(netstat -tuln | grep '^tcp6' | awk '{print $4}' | sed 's/.*://')
  for port in $open_ports; do
    ip6tables -A INPUT -p tcp --dport $port -j ACCEPT
  done
  echo "Configured IPv6 firewall rules for all open ports."
}


install_auditd() {
  if ! rpm -q audit &> /dev/null; then
    yum install -y audit
    echo "auditd has been installed."
  else
    echo "auditd is already installed."
  fi
}


enable_augenrules() {
  sed -i 's/^USE_AUGENRULES="no"/USE_AUGENRULES="yes"/' /etc/sysconfig/auditd
  echo "augenrules has been enabled."
}


enable_auditd_service() {
  systemctl enable auditd
  systemctl start auditd
  echo "auditd service has been activated."
}


enable_audit_for_prior_processes() {
  grubby --update-kernel=ALL --args="audit=1"
  echo "Audit for processes prior to auditd has been enabled."
}


configure_ipv4_outbound_established_connections
configure_ipv4_firewall_rules
set_default_ipv6_firewall_policy
configure_ipv6_loopback_traffic
configure_ipv6_outbound_established_connections
configure_ipv6_firewall_rules
install_auditd
enable_augenrules
enable_auditd_service
enable_audit_for_prior_processes
