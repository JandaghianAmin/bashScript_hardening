#!/bin/bash


check_http_server() {
  if rpm -q httpd &> /dev/null; then
    echo "HTTP Server is installed. Please remove it."
  else
    echo "HTTP Server is not installed. OK."
  fi
}


check_imap_pop3_server() {
  if rpm -q dovecot &> /dev/null; then
    echo "IMAP/POP3 Server is installed. Please remove it."
  else
    echo "IMAP/POP3 Server is not installed. OK."
  fi
}


check_samba() {
  if rpm -q samba &> /dev/null; then
    echo "Samba is installed. Please remove it."
  else
    echo "Samba is not installed. OK."
  fi
}


check_http_proxy_server() {
  if rpm -q squid &> /dev/null; then
    echo "HTTP Proxy Server is installed. Please remove it."
  else
    echo "HTTP Proxy Server is not installed. OK."
  fi
}


check_net_snmp() {
  if rpm -q net-snmp &> /dev/null; then
    echo "net-snmp is installed. Please remove it."
  else
    echo "net-snmp is not installed. OK."
  fi
}


check_nis_server() {
  if rpm -q ypserv &> /dev/null; then
    echo "NIS Server is installed. Please remove it."
  else
    echo "NIS Server is not installed. OK."
  fi
}


check_telnet_server() {
  if rpm -q telnet-server &> /dev/null; then
    echo "telnet-server is installed. Please remove it."
  else
    echo "telnet-server is not installed. OK."
  fi
}


check_nfs_utils() {
  if rpm -q nfs-utils &> /dev/null && systemctl is-active nfs-server &> /dev/null; then
    echo "nfs-utils is installed and nfs-server is active. Please remove or disable them."
  else
    echo "nfs-utils is not installed or nfs-server is inactive. OK."
  fi
}


check_rpcbind() {
  if rpm -q rpcbind &> /dev/null && systemctl is-active rpcbind &> /dev/null; then
    echo "rpcbind is installed and active. Please remove or disable it."
  else
    echo "rpcbind is not installed or inactive. OK."
  fi
}


check_mta_local_only() {
  if netstat -an | grep ":25 .*LISTEN" &> /dev/null && ! grep -q "inet_interfaces = loopback-only" /etc/postfix/main.cf; then
    echo "MTA is not configured for local-only mode. Please configure it."
  else
    echo "MTA is configured for local-only mode. OK."
  fi
}


check_http_server
check_imap_pop3_server
check_samba
check_http_proxy_server
check_net_snmp
check_nis_server
check_telnet_server
check_nfs_utils
check_rpcbind
check_mta_local_only
