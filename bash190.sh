#!/bin/bash


check_ssh_root_login() {
  if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config; then
    echo "SSH root login is disabled. OK."
  else
    echo "SSH root login is not disabled."
  fi
}


check_ssh_permit_empty_passwords() {
  if grep -q "^PermitEmptyPasswords no" /etc/ssh/sshd_config; then
    echo "SSH PermitEmptyPasswords is disabled. OK."
  else
    echo "SSH PermitEmptyPasswords is not disabled."
  fi
}


check_ssh_permit_user_environment() {
  if grep -q "^PermitUserEnvironment no" /etc/ssh/sshd_config; then
    echo "SSH PermitUserEnvironment is disabled. OK."
  else
    echo "SSH PermitUserEnvironment is not disabled."
  fi
}


check_ssh_strong_passwords() {
  if grep -qE "^\s*PasswordAuthentication\s+yes" /etc/ssh/sshd_config; then
    echo "Strong passwords are enforced. OK."
  else
    echo "Strong passwords are not enforced."
  fi
}


check_ssh_mac_algorithms() {
  if grep -q "^MACs hmac-sha2-256,hmac-sha2-512" /etc/ssh/sshd_config; then
    echo "Strong MAC algorithms are used. OK."
  else
    echo "Strong MAC algorithms are not used."
  fi
}


check_ssh_kex_algorithms() {
  if grep -q "^KexAlgorithms diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256" /etc/ssh/sshd_config; then
    echo "Strong key exchange algorithms are used. OK."
  else
    echo "Strong key exchange algorithms are not used."
  fi
}


check_ssh_idle_timeout_interval() {
  if grep -q "^ClientAliveInterval [0-9]*$" /etc/ssh/sshd_config && grep -q "^ClientAliveCountMax [0-9]*$" /etc/ssh/sshd_config; then
    echo "SSH Idle Timeout Interval is configured. OK."
  else
    echo "SSH Idle Timeout Interval is not configured."
  fi
}


check_ssh_login_grace_time() {
  if grep -q "^LoginGraceTime [0-9]\{1,2\}s" /etc/ssh/sshd_config; then
    echo "SSH LoginGraceTime is set to one minute or less. OK."
  else
    echo "SSH LoginGraceTime is not set to one minute or less."
  fi
}


check_ssh_banner() {
  if grep -q "^Banner /etc/issue.net" /etc/ssh/sshd_config; then
    echo "SSH warning banner is configured. OK."
  else
    echo "SSH warning banner is not configured."
  fi
}


check_ssh_pam() {
  if grep -q "^UsePAM yes" /etc/ssh/sshd_config; then
    echo "SSH PAM is enabled. OK."
  else
    echo "SSH PAM is not enabled."
  fi
}


check_ssh_root_login
check_ssh_permit_empty_passwords
check_ssh_permit_user_environment
check_ssh_strong_passwords
check_ssh_mac_algorithms
check_ssh_kex_algorithms
check_ssh_idle_timeout_interval
check_ssh_login_grace_time
check_ssh_banner
check_ssh_pam
