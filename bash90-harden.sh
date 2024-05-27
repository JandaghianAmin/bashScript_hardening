#!/bin/bash


remove_http_server() {
  if rpm -q httpd &> /dev/null; then
    yum remove -y httpd
    echo "HTTP Server has been removed."
  else
    echo "HTTP Server is not installed."
  fi
}


remove_imap_pop3_server() {
  if rpm -q dovecot &> /dev/null; then
    yum remove -y dovecot
    echo "IMAP/POP3 Server has been removed."
  else
    echo "IMAP/POP3 Server is not installed."
  fi
}


remove_samba() {
  if rpm -q samba &> /dev/null; then
    yum remove -y samba
    echo "Samba has been removed."
  else
    echo "Samba is not installed."
  fi
}


remove_http_proxy_server() {
  if rpm -q squid &> /dev/null; then
    yum remove -y squid
    echo "HTTP Proxy Server has been removed."
  else
    echo "HTTP Proxy Server is not installed."
  fi
}


remove_net_snmp() {
  if rpm -q net-snmp &> /dev/null; then
    yum remove -y net-snmp
    echo "net-snmp has been removed."
  else
    echo "net-snmp is not installed."
  fi
}


remove_nis_server() {
  if rpm -q ypserv &> /dev/null; then
    yum remove -y ypserv
    echo "NIS Server has been removed."
  else
    echo "NIS Server is not installed."
  fi
}


remove_telnet_server() {
  if rpm -q telnet-server &> /dev/null; then
    yum remove -y telnet-server
    echo "telnet-server has been removed."
  else
    echo "telnet-server is not installed."
  fi
}


disable_nfs_utils() {
  if rpm -q nfs-utils &> /dev/null; then
    systemctl disable nfs-server
    systemctl stop nfs-server
    echo "nfs-server has been disabled."
  else
    echo "nfs-utils is not installed."
  fi
}


disable_rpcbind() {
  if rpm -q rpcbind &> /dev/null; then
    systemctl disable rpcbind
    systemctl stop rpcbind
    echo "rpcbind has been disabled."
  else
    echo "rpcbind is not installed."
  fi
}


configure_mta_local_only() {
  if ! grep -q "inet_interfaces = loopback-only" /etc/postfix/main.cf; then
    echo "inet_interfaces = loopback-only" >> /etc/postfix/main.cf
    systemctl restart postfix
    echo "MTA has been configured for local-only mode."
  else
    echo "MTA is already configured for local-only mode."
  fi
}


remove_http_server
remove_imap_pop3_server
remove_samba
remove_http_proxy_server
remove_net_snmp
remove_nis_server
remove_telnet_server
disable_nfs_utils
disable_rpcbind
configure_mta_local_only
