#!/bin/bash


configure_cron_daily_permissions() {
  chmod 0700 /etc/cron.daily
  echo "Permissions on /etc/cron.daily configured."
}


configure_cron_weekly_permissions() {
  chmod 0700 /etc/cron.weekly
  echo "Permissions on /etc/cron.weekly configured."
}


configure_cron_monthly_permissions() {
  chmod 0700 /etc/cron.monthly
  echo "Permissions on /etc/cron.monthly configured."
}


configure_cron_d_permissions() {
  chmod 0700 /etc/cron.d
  echo "Permissions on /etc/cron.d configured."
}


configure_cron_allowed_users() {
  if [ ! -f /etc/cron.allow ]; then
    touch /etc/cron.allow
    echo "root" > /etc/cron.allow
    echo "cron restricted to authorized users."
  fi
}


configure_at_allowed_users() {
  if [ ! -f /etc/at.allow ]; then
    touch /etc/at.allow
    echo "root" > /etc/at.allow
    echo "at restricted to authorized users."
  fi
}


install_sudo() {
  if ! command -v sudo >/dev/null 2>&1; then
    yum install -y sudo
    echo "sudo installed."
  fi
}


configure_sudo_pty() {
  if ! grep -q "^Defaults.*requiretty" /etc/sudoers; then
    echo "Defaults requiretty" >> /etc/sudoers
    echo "sudo configured to use pty."
  fi
}


configure_sudo_log() {
  if ! grep -q "^Defaults.*logfile" /etc/sudoers; then
    echo "Defaults logfile=\"/var/log/sudo.log\"" >> /etc/sudoers
    touch /var/log/sudo.log
    chmod 0600 /var/log/sudo.log
    echo "sudo log file created and configured."
  fi
}


configure_sshd_config_permissions() {
  chmod 0600 /etc/ssh/sshd_config
  echo "Permissions on /etc/ssh/sshd_config configured."
}


configure_cron_daily_permissions
configure_cron_weekly_permissions
configure_cron_monthly_permissions
configure_cron_d_permissions
configure_cron_allowed_users
configure_at_allowed_users
install_sudo
configure_sudo_pty
configure_sudo_log
configure_sshd_config_permissions
