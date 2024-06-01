#!/bin/bash


configure_ssh_allow_tcp_forwarding() {
  if ! grep -q "^AllowTcpForwarding" /etc/ssh/sshd_config; then
    echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
  else
    sed -i 's/^AllowTcpForwarding.*/AllowTcpForwarding no/' /etc/ssh/sshd_config
  fi
  echo "SSH AllowTcpForwarding disabled."
}


configure_ssh_max_startups() {
  if ! grep -q "^MaxStartups" /etc/ssh/sshd_config; then
    echo "MaxStartups 10:30:60" >> /etc/ssh/sshd_config
  else
    sed -i 's/^MaxStartups.*/MaxStartups 10:30:60/' /etc/ssh/sshd_config
  fi
  echo "SSH MaxStartups configured."
}


configure_ssh_max_sessions() {
  if ! grep -q "^MaxSessions" /etc/ssh/sshd_config; then
    echo "MaxSessions 10" >> /etc/ssh/sshd_config
  else
    sed -i 's/^MaxSessions.*/MaxSessions 10/' /etc/ssh/sshd_config
  fi
  echo "SSH MaxSessions limited."
}


configure_password_creation_requirements() {
  if ! grep -q "^password.*requisite.*pam_pwquality.so" /etc/pam.d/common-password; then
    echo "password requisite pam_pwquality.so retry=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1" >> /etc/pam.d/common-password
  else
    sed -i 's/^password.*requisite.*pam_pwquality.so.*/password requisite pam_pwquality.so retry=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1/' /etc/pam.d/common-password
  fi
  echo "Password creation requirements configured."
}


configure_password_lockout_policy() {
  if ! grep -q "^auth.*required.*pam_tally2.so" /etc/pam.d/common-auth; then
    echo "auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900" >> /etc/pam.d/common-auth
  else
    sed -i 's/^auth.*required.*pam_tally2.so.*/auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900/' /etc/pam.d/common-auth
  fi
  echo "Password lockout policy configured."
}


configure_password_reuse_limit() {
  if ! grep -q "^password.*sufficient.*pam_unix.so.*remember=" /etc/pam.d/common-password; then
    echo "password sufficient pam_unix.so remember=5" >> /etc/pam.d/common-password
  else
    sed -i 's/^password.*sufficient.*pam_unix.so.*/password sufficient pam_unix.so remember=5/' /etc/pam.d/common-password
  fi
  echo "Password reuse limited."
}


configure_password_hashing_algorithm() {
  if ! grep -q "^password.*sufficient.*pam_unix.so.*sha512" /etc/pam.d/common-password; then
    echo "password sufficient pam_unix.so sha512" >> /etc/pam.d/common-password
  else
    sed -i 's/^password.*sufficient.*pam_unix.so.*/password sufficient pam_unix.so sha512/' /etc/pam.d/common-password
  fi
  echo "Password hashing algorithm set to SHA-512."
}


configure_password_expiry() {
  if ! grep -q "^PASS_MAX_DAYS" /etc/login.defs; then
    echo "PASS_MAX_DAYS 365" >> /etc/login.defs
  else
    sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 365/' /etc/login.defs
  fi
  echo "Password expiration set to 365 days or less."
}


configure_min_days_between_password_changes() {
  if ! grep -q "^PASS_MIN_DAYS" /etc/login.defs; then
    echo "PASS_MIN_DAYS 1" >> /etc/login.defs
  else
    sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 1/' /etc/login.defs
  fi
  echo "Minimum days between password changes configured."
}


configure_password_expiry_warning() {
  if ! grep -q "^PASS_WARN_AGE" /etc/login.defs; then
    echo "PASS_WARN_AGE 7" >> /etc/login.defs
  else
    sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 7/' /etc/login.defs
  fi
  echo "Password expiry warning days set to 7 or more."
}


configure_ssh_allow_tcp_forwarding
