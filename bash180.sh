#!/bin/bash


check_ssh_private_host_key_permissions() {
  for key in /etc/ssh/*_key; do
    if [ $(stat -c "%a" $key) -eq 600 ]; then
      echo "Permissions on $key are correctly configured. OK."
    else
      echo "Permissions on $key are not correctly configured."
    fi
  done
}


check_ssh_public_host_key_permissions() {
  for key in /etc/ssh/*.pub; do
    if [ $(stat -c "%a" $key) -eq 644 ]; then
      echo "Permissions on $key are correctly configured. OK."
    else
      echo "Permissions on $key are not correctly configured."
    fi
  done
}


check_ssh_protocol() {
  if grep -q "^Protocol 2" /etc/ssh/sshd_config; then
    echo "SSH Protocol is set to 2. OK."
  else
    echo "SSH Protocol is not set to 2."
  fi
}


check_ssh_access() {
  if grep -q "^AllowUsers" /etc/ssh/sshd_config; then
    echo "SSH access is restricted. OK."
  else
    echo "SSH access is not restricted."
  fi
}


check_ssh_loglevel() {
  if grep -q "^LogLevel INFO" /etc/ssh/sshd_config; then
    echo "SSH LogLevel is appropriately set. OK."
  else
    echo "SSH LogLevel is not appropriately set."
  fi
}


check_ssh_x11_forwarding() {
  if grep -q "^X11Forwarding no" /etc/ssh/sshd_config; then
    echo "SSH X11 forwarding is disabled. OK."
  else
    echo "SSH X11 forwarding is not disabled."
  fi
}


check_ssh_max_auth_tries() {
  if grep -q "^MaxAuthTries [1-4]" /etc/ssh/sshd_config; then
    echo "SSH MaxAuthTries is set to 4 or less. OK."
  else
    echo "SSH MaxAuthTries is not set to 4 or less."
  fi
}


check_ssh_ignore_rhosts() {
  if grep -q "^IgnoreRhosts yes" /etc/ssh/sshd_config; then
    echo "SSH IgnoreRhosts is enabled. OK."
  else
    echo "SSH IgnoreRhosts is not enabled."
  fi
}


check_ssh_hostbased_authentication() {
  if grep -q "^HostbasedAuthentication no" /etc/ssh/sshd_config; then
    echo "SSH HostbasedAuthentication is disabled. OK."
  else
    echo "SSH HostbasedAuthentication is not disabled."
  fi
}


check_ssh_private_host_key_permissions
check_ssh_public_host_key_permissions
check_ssh_protocol
check_ssh_access
check_ssh_loglevel
check_ssh_x11_forwarding
check_ssh_max_auth_tries
check_ssh_ignore_rhosts
check_ssh_hostbased_authentication
