#!/bin/bash


remove_nis_client() {
  if rpm -q ypbind &> /dev/null; then
    yum remove -y ypbind
    echo "NIS Client has been removed."
  else
    echo "NIS Client is not installed."
  fi
}


remove_rsh_client() {
  if rpm -q rsh &> /dev/null; then
    yum remove -y rsh
    echo "rsh client has been removed."
  else
    echo "rsh client is not installed."
  fi
}


remove_talk_client() {
  if rpm -q talk &> /dev/null; then
    yum remove -y talk
    echo "talk client has been removed."
  else
    echo "talk client is not installed."
  fi
}


remove_telnet_client() {
  if rpm -q telnet &> /dev/null; then
    yum remove -y telnet
    echo "telnet client has been removed."
  else
    echo "telnet client is not installed."
  fi
}


remove_ldap_client() {
  if rpm -q openldap-clients &> /dev/null; then
    yum remove -y openldap-clients
    echo "LDAP client has been removed."
  else
    echo "LDAP client is not installed."
  fi
}


disable_ipv6() {
  if ! sysctl net.ipv6.conf.all.disable_ipv6 | grep -q "1"; then
    echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    sysctl -p
    echo "IPv6 has been disabled."
  else
    echo "IPv6 is already disabled."
  fi
}


disable_wireless_interfaces() {
  nmcli radio wifi off
  echo "Wireless interfaces have been disabled."
}


disable_ip_forwarding() {
  if ! sysctl net.ipv4.ip_forward | grep -q "0"; then
    echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
    sysctl -p
    echo "IP forwarding has been disabled."
  else
    echo "IP forwarding is already disabled."
  fi
}


disable_packet_redirect_sending() {
  if ! sysctl net.ipv4.conf.all.send_redirects | grep -q "0"; then
    echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
    sysctl -p
    echo "Packet redirect sending has been disabled."
  else
    echo "Packet redirect sending is already disabled."
  fi
}


disable_source_routed_packets() {
  if ! sysctl net.ipv4.conf.all.accept_source_route | grep -q "0"; then
    echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
    sysctl -p
    echo "Source routed packets are no longer accepted."
  else
    echo "Source routed packets are already not accepted."
  fi
}


remove_nis_client
remove_rsh_client
remove_talk_client
remove_telnet_client
remove_ldap_client
disable_ipv6
disable_wireless_interfaces
disable_ip_forwarding
disable_packet_redirect_sending
disable_source_routed_packets
