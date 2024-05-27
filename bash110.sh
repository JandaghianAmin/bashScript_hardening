#!/bin/bash


check_icmp_redirects() {
  if sysctl net.ipv4.conf.all.accept_redirects | grep -q "0" && sysctl net.ipv4.conf.default.accept_redirects | grep -q "0"; then
    echo "ICMP redirects are not accepted. OK."
  else
    echo "ICMP redirects are accepted. Please disable them."
  fi
}


check_secure_icmp_redirects() {
  if sysctl net.ipv4.conf.all.secure_redirects | grep -q "0" && sysctl net.ipv4.conf.default.secure_redirects | grep -q "0"; then
    echo "Secure ICMP redirects are not accepted. OK."
  else
    echo "Secure ICMP redirects are accepted. Please disable them."
  fi
}


check_suspicious_packets() {
  if sysctl net.ipv4.conf.all.log_martians | grep -q "1" && sysctl net.ipv4.conf.default.log_martians | grep -q "1"; then
    echo "Suspicious packets are being logged. OK."
  else
    echo "Suspicious packets are not being logged. Please enable logging."
  fi
}


check_broadcast_icmp() {
  if sysctl net.ipv4.icmp_echo_ignore_broadcasts | grep -q "1"; then
    echo "Broadcast ICMP requests are ignored. OK."
  else
    echo "Broadcast ICMP requests are not ignored. Please ignore them."
  fi
}


check_bogus_icmp_responses() {
  if sysctl net.ipv4.icmp_ignore_bogus_error_responses | grep -q "1"; then
    echo "Bogus ICMP responses are ignored. OK."
  else
    echo "Bogus ICMP responses are not ignored. Please ignore them."
  fi
}


check_reverse_path_filtering() {
  if sysctl net.ipv4.conf.all.rp_filter | grep -q "1" && sysctl net.ipv4.conf.default.rp_filter | grep -q "1"; then
    echo "Reverse Path Filtering is enabled. OK."
  else
    echo "Reverse Path Filtering is not enabled. Please enable it."
  fi
}


check_tcp_syn_cookies() {
  if sysctl net.ipv4.tcp_syncookies | grep -q "1"; then
    echo "TCP SYN cookies are enabled. OK."
  else
    echo "TCP SYN cookies are not enabled. Please enable them."
  fi
}


check_ipv6_router_advertisements() {
  if sysctl net.ipv6.conf.all.accept_ra | grep -q "0" && sysctl net.ipv6.conf.default.accept_ra | grep -q "0"; then
    echo "IPv6 router advertisements are not accepted. OK."
  else
    echo "IPv6 router advertisements are accepted. Please disable them."
  fi
}


check_tcp_wrappers() {
  if rpm -q tcp_wrappers &> /dev/null; then
    echo "TCP Wrappers is installed. OK."
  else
    echo "TCP Wrappers is not installed. Please install it."
  fi
}


check_hosts_allow() {
  if [ -s /etc/hosts.allow ]; then
    echo "/etc/hosts.allow is configured. OK."
  else
    echo "/etc/hosts.allow is not configured. Please configure it."
  fi
}


check_icmp_redirects
check_secure_icmp_redirects
check_suspicious_packets
check_broadcast_icmp
check_bogus_icmp_responses
check_reverse_path_filtering
check_tcp_syn_cookies
check_ipv6_router_advertisements
check_tcp_wrappers
check_hosts_allow
