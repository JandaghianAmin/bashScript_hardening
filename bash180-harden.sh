#!/bin/bash


configure_ssh_private_host_key_permissions() {
  chmod 600 /etc/ssh/*_key
  echo "Permissions on SSH private host keys configured."
}


configure_ssh_public_host_key_permissions() {
  chmod 644 /etc/ssh/*.pub
  echo "Permissions on SSH public host keys configured."
}


configure_ssh_protocol() {
  if ! grep -q "^Protocol" /etc/ssh/sshd_config; then
    echo "Protocol 2" >> /etc/ssh/sshd_config
  else
    sed -i 's/^Protocol.*/Protocol 2/' /etc/ssh/sshd_config
  fi
  echo "SSH Protocol set to 2."
}


configure_ssh_access() {
  if ! grep -q "^AllowUsers" /etc/ssh/sshd_config; then
    echo "AllowUsers yourusername" >> /etc/ssh/sshd_config
  fi
  echo "SSH access restricted."
}


configure_ssh_loglevel() {
  if ! grep -q "^LogLevel" /etc/ssh/sshd_config; then
    echo "LogLevel INFO" >> /etc/ssh/sshd_config
  else
    sed -i 's/^LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config
  fi
  echo "SSH LogLevel set to INFO."
}


configure_ssh_x11_forwarding() {
  if ! grep -q "^X11Forwarding" /etc/ssh/sshd_config; then
    echo "X11Forwarding no" >> /etc/ssh/sshd_config
  else
    sed -i 's/^X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
  fi
  echo "SSH X11 forwarding disabled."
}


configure_ssh_max_auth_tries() {
  if ! grep -q "^MaxAuthTries" /etc/ssh/sshd_config; then
    echo "MaxAuthTries 4" >> /etc/ssh/sshd_config
  else
    sed -i 's/^MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
  fi
  echo "SSH MaxAuthTries set to 4 or less."
}


configure_ssh_ignore_rhosts() {
  if ! grep -q "^IgnoreRhosts" /etc/ssh/sshd_config; then
    echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config
  else
    sed -i 's/^IgnoreRhosts.*/IgnoreRhosts yes/' /etc/ssh/sshd_config
  fi
  echo "SSH IgnoreRhosts enabled."
}


configure_ssh_hostbased_authentication() {
  if ! grep -q "^HostbasedAuthentication" /etc/ssh/sshd_config; then
    echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config
  else
    sed -i 's/^HostbasedAuthentication.*/HostbasedAuthentication no/' /etc/ssh/sshd_config
  fi
  echo "SSH HostbasedAuthentication disabled."
}


configure_ssh_private_host_key_permissions
configure_ssh_public_host_key_permissions
configure_ssh_protocol
configure_ssh_access
configure_ssh_loglevel
configure_ssh_x11_forwarding
configure_ssh_max_auth_tries
configure_ssh_ignore_rhosts
configure_ssh_hostbased_authentication


service sshd restart
