#!/bin/bash

# بررسی فعال بودن سرویس rsyslog
check_rsyslog_service() {
  if systemctl is-active --quiet rsyslog; then
    echo "rsyslog service is active. OK."
  else
    echo "rsyslog service is not active."
  fi
}


check_logging_configuration() {
  if [ -f /etc/rsyslog.conf ]; then
    echo "Logging configuration file /etc/rsyslog.conf exists. OK."
  else
    echo "Logging configuration file /etc/rsyslog.conf does not exist."
  fi
}


check_rsyslog_default_file_permissions() {
  if grep -q "^\\$FileCreateMode" /etc/rsyslog.conf; then
    echo "Default file permissions for rsyslog are configured. OK."
  else
    echo "Default file permissions for rsyslog are not configured."
  fi
}


check_rsyslog_remote_logging() {
  if grep -q "@@" /etc/rsyslog.conf; then
    echo "rsyslog is configured to send logs to a remote log host. OK."
  else
    echo "rsyslog is not configured to send logs to a remote log host."
  fi
}


check_rsyslog_remote_messages() {
  if grep -q "^\\$AllowedSender" /etc/rsyslog.conf; then
    echo "rsyslog is configured to accept remote messages only from specified log hosts. OK."
  else
    echo "rsyslog is not configured to accept remote messages only from specified log hosts."
  fi
}


check_log_files_permissions() {
  incorrect_files=$(find /var/log -type f ! -perm 0600)
  if [ -z "$incorrect_files" ]; then
    echo "Permissions on all log files are correctly configured. OK."
  else
    echo "Permissions on the following log files are not correctly configured:"
    echo "$incorrect_files"
  fi
}


check_logrotate_configuration() {
  if [ -f /etc/logrotate.conf ] && [ -d /etc/logrotate.d ]; then
    echo "logrotate is configured. OK."
  else
    echo "logrotate is not configured."
  fi
}


check_cron_daemon() {
  if systemctl is-active --quiet crond; then
    echo "cron daemon is active. OK."
  else
    echo "cron daemon is not active."
  fi
}


check_crontab_permissions() {
  if [ $(stat -c "%a" /etc/crontab) -eq 600 ]; then
    echo "Permissions on /etc/crontab are correctly configured. OK."
  else
    echo "Permissions on /etc/crontab are not correctly configured."
  fi
}


check_cron_hourly_permissions() {
  if [ $(stat -c "%a" /etc/cron.hourly) -eq 700 ]; then
    echo "Permissions on /etc/cron.hourly are correctly configured. OK."
  else
    echo "Permissions on /etc/cron.hourly are not correctly configured."
  fi
}


check_rsyslog_service
check_logging_configuration
check_rsyslog_default_file_permissions
check_rsyslog_remote_logging
check_rsyslog_remote_messages
check_log_files_permissions
check_logrotate_configuration
check_cron_daemon
check_crontab_permissions
check_cron_hourly_permissions
