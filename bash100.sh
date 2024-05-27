#!/bin/bash


check_nis_client() {
  if rpm -q ypbind &> /dev/null; then
    echo "NIS Client is installed. Please remove it."
  else
    echo "NIS Client is not installed. OK."
  fi
}


check_rsh_client() {
  if rpm -q rsh &> /dev/null; then
    echo "rsh client is installed. Please remove it."
  else
    echo "rsh client is not installed. OK."
  fi
}


check_talk_client() {
  if rpm -q talk &> /dev/null; then
    echo "talk client is installed. Please remove it."
  else
    echo "talk client is not installed. OK."
  fi
}


check_telnet_client() {
  if rpm -q telnet &> /dev/null; then
    echo "telnet client is installed. Please remove it."
  else
    echo "telnet client is not installed. OK."
  fi
}


check_ldap_client() {
  if rpm -q openldap-clients &> /dev/null; then
    echo "LDAP client is installed. Please remove it."
  else
    echo "LDAP client is not installed. OK."
  fi
}


check_ipv6() {
  if sysctl net.ipv6.conf.all.disable_ipv6 | grep -q "1"; then
    echo "IPv6 is disabled. OK."
  else
    echo "IPv6 is not disabled. Please disable it."
  fi
}


check_wireless_interfaces() {
  if nmcli radio wifi | grep -q "disabled"; then
    echo "Wireless interfaces are disabled. OK."
  else
    echo "Wireless interfaces are not disabled. Please disable them."
  fi
}


check_ip_forwarding() {
  if sysctl net.ipv4.ip_forward | grep -q "0"; then
    echo "IP forwarding is disabled. OK."
  else
    echo "IP forwarding is not disabled. Please disable it."
  fi
}


check_packet_redirect_sending() {
  if sysctl net.ipv4.conf.all.send_redirects | grep -q "0"; then
    echo "Packet redirect sending is disabled. OK."
  else
    echo "Packet redirect sending is not disabled. Please disable it."
  fi
}


check_source_routed_packets() {
  if sysctl net.ipv4.conf.all.accept_source_route | grep -q "0"; then
    echo "Source routed packets are not accepted. OK."
  else
    echo "Source routed packets are accepted. Please disable them."
  fi
}


check_nis_client
check_rsh_client
check_talk_client
check_telnet_client
check_ldap_client
check_ipv6
check_wireless_interfaces
check_ip_forwarding
check_packet_redirect_sending
check_source_routed_packets
