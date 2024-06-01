#!/bin/bash


configure_password_inactive_lock() {
  awk -F: '($2 != "*" && $2 != "!" && $2 != "") {print $1}' /etc/shadow | while read user; do
    chage --inactive 30 $user
  done
  echo "Password inactive lock set to 30 days or less for all users."
}


configure_password_last_change() {
  awk -F: '($2 != "*" && $2 != "!" && $2 != "") {print $1}' /etc/shadow | while read user; do
    chage --lastday 0 $user
  done
  echo "Last password change date set to past for all users."
}


configure_secure_system_accounts() {
  awk -F: '($3 < 1000) {print $1}' /etc/passwd | while read user; do
    usermod -L $user
  done
  echo "System accounts secured."
}


configure_root_gid() {
  usermod -g 0 root
  echo "Default group for the root account set to GID 0."
}


configure_user_shell_timeout() {
  echo "TMOUT=900" >> /etc/profile
  echo "User shell timeout configured."
}


configure_default_umask() {
  echo "umask 077" >> /etc/profile
  echo "Default user umask configured."
}


configure_root_console_login() {
  echo "console" >> /etc/securetty
  echo "Root login to system console limited."
}


configure_su_access() {
  echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su
  echo "Access to the su command restricted."
}


configure_audit_file_permissions() {
  chmod 600 /etc/audit/auditd.conf
  echo "Audit file permissions configured."
}


configure_passwd_file_permissions() {
  chmod 644 /etc/passwd
  echo "Permissions for /etc/passwd configured."
}


configure_password_inactive_lock
configure_password_last_change
configure_secure_system_accounts
configure_root_gid
configure_user_shell_timeout
configure_default_umask
configure_root_console_login
configure_su_access
configure_audit_file_permissions
configure_passwd_file_permissions
