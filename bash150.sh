#!/bin/bash


check_dac_permission_modification() {
  if auditctl -l | grep -q "perm_mod"; then
    echo "DAC permission modification events are being collected. OK."
  else
    echo "DAC permission modification events are not being collected."
  fi
}


check_unsuccessful_unauthorized_file_access_attempts() {
  if auditctl -l | grep -q "access"; then
    echo "Unsuccessful unauthorized file access attempts are being collected. OK."
  else
    echo "Unsuccessful unauthorized file access attempts are not being collected."
  fi
}


check_use_of_privileged_commands() {
  if auditctl -l | grep -q "privileged"; then
    echo "Use of privileged commands is being collected. OK."
  else
    echo "Use of privileged commands is not being collected."
  fi
}


check_successful_file_system_mounts() {
  if auditctl -l | grep -q "mount"; then
    echo "Successful file system mounts are being collected. OK."
  else
    echo "Successful file system mounts are not being collected."
  fi
}


check_file_deletion_events_by_users() {
  if auditctl -l | grep -q "delete"; then
    echo "File deletion events by users are being collected. OK."
  else
    echo "File deletion events by users are not being collected."
  fi
}


check_sudoers_changes() {
  if auditctl -l | grep -q "scope"; then
    echo "Sudoers changes are being collected. OK."
  else
    echo "Sudoers changes are not being collected."
  fi
}


check_sudo_commands_execution() {
  if auditctl -l | grep -q "action"; then
    echo "Sudo commands execution is being collected. OK."
  else
    echo "Sudo commands execution is not being collected."
  fi
}


check_kernel_module_loading_unloading() {
  if auditctl -l | grep -q "modules"; then
    echo "Kernel module loading/unloading is being collected. OK."
  else
    echo "Kernel module loading/unloading is not being collected."
  fi
}


check_audit_configuration_immutable() {
  if auditctl -s | grep -q "enabled.*1"; then
    echo "Audit configuration is immutable. OK."
  else
    echo "Audit configuration is not immutable."
  fi
}


check_rsyslog_installed() {
  if command -v rsyslogd >/dev/null 2>&1; then
    echo "rsyslog is installed. OK."
  else
    echo "rsyslog is not installed."
  fi
}


check_dac_permission_modification
check_unsuccessful_unauthorized_file_access_attempts
check_use_of_privileged_commands
check_successful_file_system_mounts
check_file_deletion_events_by_users
check_sudoers_changes
check_sudo_commands_execution
check_kernel_module_loading_unloading
check_audit_configuration_immutable
check_rsyslog_installed
