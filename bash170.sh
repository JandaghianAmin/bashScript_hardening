#!/bin/bash


check_cron_daily_permissions() {
  if [ $(stat -c "%a" /etc/cron.daily) -eq 700 ]; then
    echo "Permissions on /etc/cron.daily are correctly configured. OK."
  else
    echo "Permissions on /etc/cron.daily are not correctly configured."
  fi
}


check_cron_weekly_permissions() {
  if [ $(stat -c "%a" /etc/cron.weekly) -eq 700 ]; then
    echo "Permissions on /etc/cron.weekly are correctly configured. OK."
  else
    echo "Permissions on /etc/cron.weekly are not correctly configured."
  fi
}


check_cron_monthly_permissions() {
  if [ $(stat -c "%a" /etc/cron.monthly) -eq 700 ]; then
    echo "Permissions on /etc/cron.monthly are correctly configured. OK."
  else
    echo "Permissions on /etc/cron.monthly are not correctly configured."
  fi
}


check_cron_d_permissions() {
  if [ $(stat -c "%a" /etc/cron.d) -eq 700 ]; then
    echo "Permissions on /etc/cron.d are correctly configured. OK."
  else
    echo "Permissions on /etc/cron.d are not correctly configured."
  fi
}


check_cron_allowed_users() {
  if [ -f /etc/cron.allow ]; then
    echo "cron is restricted to authorized users. OK."
  else
    echo "cron is not restricted to authorized users."
  fi
}


check_at_allowed_users() {
  if [ -f /etc/at.allow ]; then
    echo "at is restricted to authorized users. OK."
  else
    echo "at is not restricted to authorized users."
  fi
}


check_sudo_installed() {
  if command -v sudo >/dev/null 2>&1; then
    echo "sudo is installed. OK."
  else
    echo "sudo is not installed."
  fi
}


check_sudo_pty() {
  if grep -q "^Defaults.*requiretty" /etc/sudoers; then
    echo "sudo commands use pty. OK."
  else
    echo "sudo commands do not use pty."
  fi
}


check_sudo_log() {
  if grep -q "^Defaults.*logfile" /etc/sudoers; then
    echo "sudo log file exists. OK."
  else
    echo "sudo log file does not exist."
  fi
}


check_sshd_config_permissions() {
  if [ $(stat -c "%a" /etc/ssh/sshd_config) -eq 600 ]; then
    echo "Permissions on /etc/ssh/sshd_config are correctly configured. OK."
  else
    echo "Permissions on /etc/ssh/sshd_config are not correctly configured."
  fi
}


check_cron_daily_permissions
check_cron_weekly_permissions
check_cron_monthly_permissions
check_cron_d_permissions
check_cron_allowed_users
check_at_allowed_users
check_sudo_installed
check_sudo_pty
check_sudo_log
check_sshd_config_permissions
