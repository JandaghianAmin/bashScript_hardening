#!/bin/bash


configure_dac_permission_modification() {
  auditctl -a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -k perm_mod
  auditctl -a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -k perm_mod
  auditctl -a always,exit -F arch=b64 -S chown -S fchown -S fchownat -k perm_mod
  auditctl -a always,exit -F arch=b32 -S chown -S fchown -S fchownat -k perm_mod
  auditctl -a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -k perm_mod
  auditctl -a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -k perm_mod
  auditctl -a always,exit -F arch=b64 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod
  auditctl -a always,exit -F arch=b32 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod
  echo "Configured collection of DAC permission modification events."
}


configure_unsuccessful_unauthorized_file_access_attempts() {
  auditctl -a always,exit -F arch=b64 -S open -S openat -F exit=-EACCES -k access
  auditctl -a always,exit -F arch=b32 -S open -S openat -F exit=-EACCES -k access
  auditctl -a always,exit -F arch=b64 -S open -S openat -F exit=-EPERM -k access
  auditctl -a always,exit -F arch=b32 -S open -S openat -F exit=-EPERM -k access
  echo "Configured collection of unsuccessful unauthorized file access attempts."
}


configure_use_of_privileged_commands() {
  find / -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" }' | xargs -I {} auditctl {}
  echo "Configured collection of use of privileged commands."
}


configure_successful_file_system_mounts() {
  auditctl -a always,exit -F arch=b64 -S mount -k mount
  auditctl -a always,exit -F arch=b32 -S mount -k mount
  echo "Configured collection of successful file system mounts."
}


configure_file_deletion_events_by_users() {
  auditctl -a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -k delete
  auditctl -a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -k delete
  echo "Configured collection of file deletion events by users."
}


configure_sudoers_changes() {
  auditctl -w /etc/sudoers -p wa -k scope
  echo "Configured collection of sudoers changes."
}


configure_sudo_commands_execution() {
  auditctl -w /var/log/sudo.log -p wa -k actions
  echo "Configured collection of sudo commands execution."
}


configure_kernel_module_loading_unloading() {
  auditctl -w /sbin/insmod -p x -k modules
  auditctl -w /sbin/rmmod -p x -k modules
  auditctl -w /sbin/modprobe -p x -k modules
  auditctl -a always,exit -F arch=b64 -S init_module -S delete_module -k modules
  echo "Configured collection of kernel module loading/unloading."
}


configure_audit_configuration_immutable() {
  auditctl -e 2
  echo "Configured audit system to be immutable."
}


install_rsyslog() {
  if ! command -v rsyslogd >/dev/null 2>&1; then
    apt-get update && apt-get install -y rsyslog
    echo "rsyslog installed."
  else
    echo "rsyslog is already installed."
  fi
}


configure_dac_permission_modification
configure_unsuccessful_unauthorized_file_access_attempts
configure_use_of_privileged_commands
configure_successful_file_system_mounts
configure_file_deletion_events_by_users
configure_sudoers_changes
configure_sudo_commands_execution
configure_kernel_module_loading_unloading
configure_audit_configuration_immutable
install_rsyslog
