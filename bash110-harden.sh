#!/bin/bash


disable_icmp_redirects() {
  echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
  sysctl -p
  echo "ICMP redirects have been disabled."
}


disable_secure_icmp_redirects() {
  echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
  sysctl -p
  echo "Secure ICMP redirects have been disabled."
}


enable_suspicious_packets_logging() {
  echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
  sysctl -p
  echo "Suspicious packets logging has been enabled."
}


ignore_broadcast_icmp() {
  echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
  sysctl -p
  echo "Broadcast ICMP requests are now ignored."
}


ignore_bogus_icmp_responses() {
  echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
  sysctl -p
  echo "Bogus ICMP responses are now ignored."
}


enable_reverse_path_filtering() {
  echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
  sysctl -p
  echo "Reverse Path Filtering has been enabled."
}


enable_tcp_syn_cookies() {
  echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
  sysctl -p
  echo "TCP SYN cookies have been enabled."
}


disable_ipv6_router_advertisements() {
  echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
  echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
  sysctl -p
  echo "IPv6 router advertisements have been disabled."
}


install_tcp_wrappers() {
  if ! rpm -q tcp_wrappers &> /dev/null; then
    yum install -y tcp_wrappers
    echo "TCP Wrappers has been installed."
  else
    echo "TCP Wrappers is already installed."
  fi
}


configure_hosts_allow() {
  echo "ALL: ALL" >> /etc/hosts.allow
  echo "/etc/hosts.allow has been configured."
}


disable_icmp_redirects
disable_secure_icmp_redirects
enable_suspicious_packets_logging
ignore_broadcast_icmp
ignore_bogus_icmp_responses
enable_reverse_path_filtering
enable_tcp_syn_cookies
disable_ipv6_router_advertisements
install_tcp_wrappers
configure_hosts_allow
