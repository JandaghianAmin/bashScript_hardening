#!/bin/bash


configure_ssh_root_login() {
  if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config
  else
    sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
  fi
  echo "SSH root login disabled."
}


configure_ssh_permit_empty_passwords() {
  if ! grep -q "^PermitEmptyPasswords" /etc/ssh/sshd_config; then
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
  else
    sed -i 's/^PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
  fi
  echo "SSH PermitEmptyPasswords disabled."
}


configure_ssh_permit_user_environment() {
  if ! grep -q "^PermitUserEnvironment" /etc/ssh/sshd_config; then
    echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config
  else
    sed -i 's/^PermitUserEnvironment.*/PermitUserEnvironment no/' /etc/ssh/sshd_config
  fi
  echo "SSH PermitUserEnvironment disabled."
}


configure_ssh_strong_passwords() {
  if ! grep -q "^PasswordAuthentication" /etc/ssh/sshd_config; then
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
  else
    sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  fi
  echo "Strong passwords enforced."
}


configure_ssh_mac_algorithms() {
  if ! grep -q "^MACs" /etc/ssh/sshd_config; then
    echo "MACs hmac-sha2-256,hmac-sha2-512" >> /etc/ssh/sshd_config
  else
    sed -i 's/^MACs.*/MACs hmac-sha2-256,hmac-sha2-512/' /etc/ssh/sshd_config
  fi
  echo "Strong MAC algorithms set."
}


configure_ssh_kex_algorithms() {
  if ! grep -q "^KexAlgorithms" /etc/ssh/sshd_config; then
    echo "KexAlgorithms diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256" >> /etc/ssh/sshd_config
  else
    sed -i 's/^KexAlgorithms.*/KexAlgorithms diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256/' /etc/ssh/sshd_config
  fi
  echo "Strong key exchange algorithms set."
}


configure_ssh_idle_timeout_interval() {
  if ! grep -q "^ClientAliveInterval" /etc/ssh/sshd_config; then
    echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
  else
    sed -i 's/^ClientAliveInterval.*/ClientAliveInterval 300/' /etc/ssh/sshd_config
  fi

  if ! grep -q "^ClientAliveCountMax" /etc/ssh/sshd_config; then
    echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
  else
    sed -i 's/^ClientAliveCountMax.*/ClientAliveCountMax 0/' /etc/ssh/sshd_config
  fi
  echo "SSH Idle Timeout Interval configured."
}


configure_ssh_login_grace_time() {
  if ! grep -q "^LoginGraceTime" /etc/ssh/sshd_config; then
    echo "LoginGraceTime 60" >> /etc/ssh/sshd_config
  else
    sed -i 's/^LoginGraceTime.*/LoginGraceTime 60/' /etc/ssh/sshd_config
  fi
  echo "SSH LoginGraceTime set to one minute or less."
}


configure_ssh_banner() {
  if ! grep -q "^Banner" /etc/ssh/sshd_config; then
    echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
  else
    sed -i 's/^Banner.*/Banner \/etc\/issue.net/' /etc/ssh/sshd_config
  fi
  echo "SSH warning banner configured."
}


configure_ssh_pam() {
  if ! grep -q "^UsePAM" /etc/ssh/sshd_config; then
    echo "UsePAM yes" >> /etc/ssh/sshd_config
  else
    sed -i 's/^UsePAM.*/UsePAM yes/' /etc/ssh/sshd_config
  fi
  echo "SSH PAM enabled."
}


configure_ssh_root_login
configure_ssh_permit_empty_passwords
configure_ssh_permit_user_environment
configure_ssh_strong_passwords
configure_ssh_mac_algorithms
configure_ssh_kex_algorithms
configure_ssh_idle_timeout_interval
configure_ssh_login_grace_time
configure_ssh_banner
configure_ssh_pam


service sshd restart
