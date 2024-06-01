#!/bin/bash


check_password_inactive_lock() {
  if awk -F: '($2 != "*" && $2 != "!" && $2 != "") { if($7 < 30) {print $1" has an inactive lock period of less than 30 days."}}' /etc/shadow; then
    echo "Password inactive lock is 30 days or less for all users. OK."
  else
    echo "Password inactive lock is not 30 days or less for all users."
  fi
}


check_password_last_change() {
  if awk -F: '($2 != "*" && $2 != "!" && $2 != "") { if($3 > 0) {print $1" has a valid last password change date."}}' /etc/shadow; then
    echo "All users have a valid last password change date. OK."
  else
    echo "Not all users have a valid last password change date."
  fi
}


check_secure_system_accounts() {
  if awk -F: '($3 < 1000) {print $1" is a system account."}' /etc/passwd; then
    echo "System accounts are secure. OK."
  else
    echo "System accounts are not secure."
  fi
}


check_root_gid() {
  if grep -q "^root:.*:0:" /etc/passwd; then
    echo "The default group for the root account is GID 0. OK."
  else
    echo "The default group for the root account is not GID 0."
  fi
}


check_user_shell_timeout() {
  if grep -q "TMOUT=900" /etc/profile; then
    echo "User shell timeout is configured. OK."
  else
    echo "User shell timeout is not configured."
  fi
}


check_default_umask() {
  if grep -q "umask 077" /etc/profile; then
    echo "Default user umask is configured. OK."
  else
    echo "Default user umask is not configured."
  fi
}


check_root_console_login() {
  if grep -q "console" /etc/securetty; then
    echo "Root login to system console is limited. OK."
  else
    echo "Root login to system console is not limited."
  fi
}


check_su_access() {
  if grep -q "^auth.*required.*pam_wheel.so" /etc/pam.d/su; then
    echo "Access to the su command is restricted. OK."
  else
    echo "Access to the su command is not restricted."
  fi
}


check_audit_file_permissions() {
  if ls -l /etc/audit/auditd.conf | grep -q ".---"; then
    echo "Audit file permissions are configured. OK."
  else
    echo "Audit file permissions are not configured."
  fi
}


check_passwd_file_permissions() {
  if ls -l /etc/passwd | grep -q "rw-r--r--"; then
    echo "Permissions for /etc/passwd are configured. OK."
  else
    echo "Permissions for /etc/passwd are not configured."
  fi
}


check_password_inactive_lock
check_password_last_change
check_secure_system_accounts
check_root_gid
check_user_shell_timeout
check_default_umask
check_root_console_login
check_su_access
check_audit_file_permissions
check_passwd_file_permissions
