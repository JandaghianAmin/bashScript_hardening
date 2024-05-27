#!/bin/bash


configure_local_login_banner() {
  echo "Authorized uses only. All activity may be monitored and reported." > /etc/motd
  echo "Local login banner has been configured."
}


configure_remote_login_banner() {
  echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue.net
  echo "Remote login banner has been configured."
}


set_motd_permissions() {
  chmod 644 /etc/motd
  echo "Permissions for /etc/motd have been configured."
}


set_issue_permissions() {
  chmod 644 /etc/issue
  echo "Permissions for /etc/issue have been configured."
}


set_issue_net_permissions() {
  chmod 644 /etc/issue.net
  echo "Permissions for /etc/issue.net have been configured."
}


remove_gdm() {
  if rpm -q gdm &> /dev/null; then
    yum remove -y gdm
    echo "GNOME Display Manager has been removed."
  else
    echo "GNOME Display Manager is already removed."
  fi
}


configure_gdm_login_banner() {
  mkdir -p /etc/dconf/db/gdm.d
  echo "[org/gnome/login-screen]" > /etc/dconf/db/gdm.d/01-banner-message
  echo "banner-message-enable=true" >> /etc/dconf/db/gdm.d/01-banner-message
  echo "banner-message-text='Authorized uses only. All activity may be monitored and reported.'" >> /etc/dconf/db/gdm.d/01-banner-message
  dconf update
  echo "GDM login banner has been configured."
}


disable_last_login() {
  if ! grep -q "PrintLastLog no" /etc/ssh/sshd_config; then
    echo "PrintLastLog no" >> /etc/ssh/sshd_config
    systemctl restart sshd
    echo "Display of last login has been disabled."
  else
    echo "Display of last login is already disabled."
  fi
}


disable_xdmcp() {
  if ! grep -q "Enable=false" /etc/gdm/custom.conf; then
    echo "[xdmcp]" >> /etc/gdm/custom.conf
    echo "Enable=false" >> /etc/gdm/custom.conf
    systemctl restart gdm
    echo "XDCMP has been disabled."
  else
    echo "XDCMP is already disabled."
  fi
}


install_updates() {
  yum update -y --security
  echo "All updates, patches, and additional security software have been installed."
}


configure_local_login_banner
configure_remote_login_banner
set_motd_permissions
set_issue_permissions
set_issue_net_permissions
remove_gdm
configure_gdm_login_banner
disable_last_login
disable_xdmcp
install_updates
