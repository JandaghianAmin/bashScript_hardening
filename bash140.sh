#!/bin/bash


check_audit_log_storage_size() {
  if grep -q "^max_log_file" /etc/audit/auditd.conf; then
    echo "Audit log storage size is configured. OK."
  else
    echo "Audit log storage size is not configured."
  fi
}


check_audit_log_not_deleted() {
  if grep -q "^max_log_file_action = KEEP_LOGS" /etc/audit/auditd.conf; then
    echo "Audit logs are not automatically deleted. OK."
  else
    echo "Audit logs are set to be automatically deleted. Please set max_log_file_action to KEEP_LOGS."
  fi
}


check_system_on_audit_log_full() {
  if grep -q "^space_left_action = email" /etc/audit/auditd.conf; then
    echo "System is configured to email on audit log full. OK."
  else
    echo "System is not configured to email on audit log full. Please set space_left_action to email."
  fi
}


check_audit_backlog_limit() {
  if grep -q "^audit_backlog_limit" /etc/audit/audit.rules; then
    echo "Audit backlog limit is configured. OK."
  else
    echo "Audit backlog limit is not configured."
  fi
}


check_time_change_events() {
  if auditctl -l | grep -q "time-change"; then
    echo "Time change events are being collected. OK."
  else
    echo "Time change events are not being collected."
  fi
}


check_user_group_change_events() {
  if auditctl -l | grep -q "identity"; then
    echo "User/group change events are being collected. OK."
  else
    echo "User/group change events are not being collected."
  fi
}


check_network_environment_change_events() {
  if auditctl -l | grep -q "system-locale"; then
    echo "Network environment change events are being collected. OK."
  else
    echo "Network environment change events are not being collected."
  fi
}


check_mandatory_access_control_change_events() {
  if auditctl -l | grep -q "MAC-policy"; then
    echo "Mandatory access control change events are being collected. OK."
  else
    echo "Mandatory access control change events are not being collected."
  fi
}


check_login_logout_events() {
  if auditctl -l | grep -q "logins"; then
    echo "Login/logout events are being collected. OK."
  else
    echo "Login/logout events are not being collected."
  fi
}


check_session_start_events() {
  if auditctl -l | grep -q "session"; then
    echo "Session start information is being collected. OK."
  else
    echo "Session start information is not being collected."
  fi
}


check_audit_log_storage_size
check_audit_log_not_deleted
check_system_on_audit_log_full
check_audit_backlog_limit
check_time_change_events
check_user_group_change_events
check_network_environment_change_events
check_mandatory_access_control_change_events
check_login_logout_events
check_session_start_events
