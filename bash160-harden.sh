#!/bin/bash


enable_rsyslog_service() {
  systemctl enable rsyslog
  systemctl start rsyslog
  echo "rsyslog service enabled and started."
}


configure_logging() {
  if [ ! -f /etc/rsyslog.conf ]; then
    echo "*.* @@remote-log-server" >> /etc/rsyslog.conf
    echo "Logging configuration file created and configured for remote logging."
  fi
}


configure_rsyslog_default_file_permissions() {
  if ! grep -q "^\\$FileCreateMode" /etc/rsyslog.conf; then
    echo "\$FileCreateMode 0640" >> /etc/rsyslog.conf
    echo "Default file permissions for rsyslog configured."
  fi
}


configure_rsyslog_remote_logging() {
  if ! grep -q "@@" /etc/rsyslog.conf; then
    echo "*.* @@remote-log-server" >> /etc/rsyslog.conf
    echo "rsyslog configured to send logs to a remote log host."
  fi
}


configure_rsyslog_remote_messages() {
  if ! grep -q "^\\$AllowedSender" /etc/rsyslog.conf; then
    echo "\$AllowedSender UDP, 127.0.0.1, 192.168.0.1" >> /etc/rsyslog.conf
    echo "rsyslog configured to accept remote messages only from specified log hosts."
  fi
}


configure_log_files_permissions() {
  find /var/log -type f -exec chmod 0640 {} \;
  echo "Permissions on all log files configured."
}


configure_logrotate() {
  if [ ! -f /etc/logrotate.conf ]; then
    cat <<EOF > /etc/logrotate.conf
/var/log/messages {
    rotate 5
    weekly
    minsize 1M
    create 0600 root utmp
    postrotate
        /usr/bin/killall -HUP syslogd
    endscript
}
EOF
    echo "logrotate configured."
  fi
}


enable_cron_daemon() {
  systemctl enable crond
  systemctl start crond
  echo "cron daemon enabled and started."
}


configure_crontab_permissions() {
  chmod 0600 /etc/crontab
  echo "Permissions on /etc/crontab configured."
}


configure_cron_hourly_permissions() {
  chmod 0700 /etc/cron.hourly
  echo "Permissions on /etc/cron.hourly configured."
}


enable_rsyslog_service
configure_logging
configure_rsyslog_default_file_permissions
configure_rsyslog_remote_logging
configure_rsyslog_remote_messages
configure_log_files_permissions
configure_logrotate
enable_cron_daemon
configure_crontab_permissions
configure_cron_hourly_permissions
