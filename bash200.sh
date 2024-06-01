#!/bin/bash

check_ssh_allow_tcp_forwarding() {
  if grep -q "^AllowTcpForwarding no" /etc/ssh/sshd_config; then
    echo "SSH AllowTcpForwarding is disabled. OK."
  else
    echo "SSH AllowTcpForwarding is not disabled."
  fi
}


check_ssh_max_startups() {
  if grep -q "^MaxStartups" /etc/ssh/sshd_config; then
    echo "SSH MaxStartups is configured. OK."
  else
    echo "SSH MaxStartups is not configured."
  fi
}


check_ssh_max_sessions() {
  if grep -q "^MaxSessions" /etc/ssh/sshd_config; then
    echo "SSH MaxSessions is limited. OK."
  else
    echo "SSH MaxSessions is not limited."
  fi
}


check_password_creation_requirements() {
  if grep -q "^password.*requisite.*pam_pwquality.so" /etc/pam.d/common-password; then
    echo "Password creation requirements are configured. OK."
  else
    echo "Password creation requirements are not configured."
  fi
}


check_password_lockout_policy() {
  if grep -q "^auth.*required.*pam_tally2.so" /etc/pam.d/common-auth; then
    echo "Password lockout policy is configured. OK."
  else
    echo "Password lockout policy is not configured."
  fi
}


check_password_reuse_limit() {
  if grep -q "^password.*sufficient.*pam_unix.so.*remember=" /etc/pam.d/common-password; then
    echo "Password reuse is limited. OK."
  else
    echo "Password reuse is not limited."
  fi
}


check_password_hashing_algorithm() {
  if grep -q "^password.*sufficient.*pam_unix.so.*sha512" /etc/pam.d/common-password; then
    echo "Password hashing algorithm is SHA-512. OK."
  else
    echo "Password hashing algorithm is not SHA-512."
  fi
}


check_password_expiry() {
  if grep -q "^PASS_MAX_DAYS\s\+365" /etc/login.defs; then
    echo "Password expiration is 365 days or less. OK."
  else
    echo "Password expiration is not 365 days or less."
  fi
}


check_min_days_between_password_changes() {
  if grep -q "^PASS_MIN_DAYS" /etc/login.defs; then
    echo "Minimum days between password changes is configured. OK."
  else
    echo "Minimum days between password changes is not configured."
  fi
}


check_password_expiry_warning() {
  if grep -q "^PASS_WARN_AGE\s\+7" /etc/login.defs; then
    echo "Password expiry warning days are 7 or more. OK."
  else
    echo "Password expiry warning days are not 7 or more."
  fi
}


check_ssh_allow_tcp_forwarding
check_ssh_max_startups
check_ssh_max_sessions
check_password_creation_requirements
check_password_lockout_policy
check_password_reuse_limit
check_password_hashing_algorithm
check_password_expiry
check_min_days_between_password_changes
check_password_expiry_warning
