#!/bin/bash


configure_audit_log_storage_size() {
  if ! grep -q "^max_log_file" /etc/audit/auditd.conf; then
    echo "max_log_file = 8" >> /etc/audit/auditd.conf
    echo "Configured audit log storage size."
  else
    echo "Audit log storage size is already configured."
  fi
}


configure_audit_log_not_deleted() {
  if ! grep -q "^max_log_file_action" /etc/audit/auditd.conf; then
    echo "max_log_file_action = KEEP_LOGS" >> /etc/audit/auditd.conf
    echo "Configured audit logs to not be automatically deleted."
  else
    sed -i 's/^max_log_file_action.*/max_log_file_action = KEEP_LOGS/' /etc/audit/auditd.conf
    echo "Updated audit logs configuration to not be automatically deleted."
  fi
}


configure_system_on_audit_log_full() {
  if ! grep -q "^space_left_action" /etc/audit/auditd.conf; then
    echo "space_left_action = email" >> /etc/audit/auditd.conf
    echo "Configured system to email on audit log full."
  else
    sed -i 's/^space_left_action.*/space_left_action = email/' /etc/audit/auditd.conf
    echo "Updated system configuration to email on audit log full."
  fi
}


configure_audit_backlog_limit() {
  if ! grep -q "^audit_backlog_limit" /etc/audit/audit.rules; then
    echo "-b 8192" >> /etc/audit/audit.rules
    echo "Configured audit backlog limit."
  else
    echo "Audit backlog limit is already configured."
  fi
}


configure_time_change_events() {
  auditctl -a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
  auditctl -a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
  auditctl -a always,exit -F arch=b64 -S clock_settime -k time-change
  auditctl -a always,exit -F arch=b32 -S clock_settime -k time-change
  auditctl -w /etc/localtime -p wa -k time-change
  echo "Configured collection of time change events."
}


configure_user_group_change_events() {
  auditctl -w /etc/group -p wa -k identity
  auditctl -w /etc/passwd -p wa -k identity
  auditctl -w /etc/gshadow -p wa -k identity
  auditctl -w /etc/shadow -p wa -k identity
  auditctl -w /etc/security/opasswd -p wa -k identity
  echo "Configured collection of user/group change events."
}


configure_network_environment_change_events() {
  auditctl -a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
  auditctl -a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
  auditctl -w /etc/issue -p wa -k system-locale
  auditctl -w /etc/issue.net -p wa -k system-locale
  auditctl -w /etc/hosts -p wa -k system-locale
  auditctl -w /etc/sysconfig/network -p wa -k system-locale
  echo "Configured collection of network environment change events."
}


configure_mandatory_access_control_change_events() {
  auditctl -w /etc/selinux/ -p wa -k MAC-policy
  echo "Configured collection of mandatory access control change events."
}


configure_login_logout_events() {
  auditctl -w /var/log/faillog -p wa -k logins
  auditctl -w /var/log/lastlog -p wa -k logins
  auditctl -w /var/run/utmp -p wa -k logins
  auditctl -w /var/log/wtmp -p wa -k logins
  auditctl -w /var/log/btmp -p wa -k logins
  echo "Configured collection of login/logout events."
}


configure_session_start_events() {
  auditctl -w /var/run/utmp -p wa -k session
  echo "Configured collection of session start information."
}


configure_audit_log_storage_size
configure_audit_log_not_deleted
configure_system_on_audit_log_full
configure_audit_backlog_limit
configure_time_change_events
configure_user_group_change_events
configure_network_environment_change_events
configure_mandatory_access_control_change_events
configure_login
