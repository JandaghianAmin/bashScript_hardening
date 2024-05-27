#!/bin/bash


check_local_login_banner() {
  if grep -q "Authorized uses only. All activity may be monitored and reported." /etc/motd; then
    echo "Local login banner is configured correctly. OK."
  else
    echo "Local login banner is not configured correctly. Please configure it."
  fi
}


check_remote_login_banner() {
  if grep -q "Authorized uses only. All activity may be monitored and reported." /etc/issue.net; then
    echo "Remote login banner is configured correctly. OK."
  else
    echo "Remote login banner is not configured correctly. Please configure it."
  fi
}


check_motd_permissions() {
  if [ "$(stat -c "%a" /etc/motd)" -eq 644 ]; then
    echo "Permissions for /etc/motd are configured correctly. OK."
  else
    echo "Permissions for /etc/motd are not configured correctly. Please configure them."
  fi
}


check_issue_permissions() {
  if [ "$(stat -c "%a" /etc/issue)" -eq 644 ]; then
    echo "Permissions for /etc/issue are configured correctly. OK."
  else
    echo "Permissions for /etc/issue are not configured correctly. Please configure them."
  fi
}


check_issue_net_permissions() {
  if [ "$(stat -c "%a" /etc/issue.net)" -eq 644 ]; then
    echo "Permissions for /etc/issue.net are configured correctly. OK."
  else
    echo "Permissions for /etc/issue.net are not configured correctly. Please configure them."
  fi
}


check_gdm_removed() {
  if rpm -q gdm &> /dev/null; then
    echo "GNOME Display Manager is installed. Please remove it."
  else
    echo "GNOME Display Manager is not installed. OK."
  fi
}


check_gdm_login_banner() {
  if [ -f /etc/dconf/db/gdm.d/01-banner-message ]; then
    if grep -q "banner-message-enable=true" /etc/dconf/db/gdm.d/01-banner-message; then
      echo "GDM login banner is configured correctly. OK."
    else
      echo "GDM login banner is not configured correctly. Please configure it."
    fi
  else
    echo "GDM login banner configuration file not found. Please configure it."
  fi
}


check_last_login_disabled() {
  if grep -q "PrintLastLog no" /etc/ssh/sshd_config; then
    echo "Display of last login is disabled. OK."
  else
    echo "Display of last login is not disabled. Please disable it."
  fi
}


check_xdmcp_disabled() {
  if grep -q "Enable=false" /etc/gdm/custom.conf; then
    echo "XDCMP is disabled. OK."
  else
    echo "XDCMP is not disabled. Please disable it."
  fi
}


check_updates_installed() {
  updates=$(yum check-update --security | wc -l)
  if [ "$updates" -eq 0 ]; then
    echo "All updates, patches, and additional security software are installed. OK."
  else
    echo "There are pending updates, patches, or additional security software. Please install them."
  fi
}


check_local_login_banner
check_remote_login_banner
check_motd_permissions
check_issue_permissions
check_issue_net_permissions
check_gdm_removed
check_gdm_login_banner
check_last_login_disabled
check_xdmcp_disabled
check_updates_installed
