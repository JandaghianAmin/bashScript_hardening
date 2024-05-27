#!/bin/bash


check_chargen_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "chargen" /etc/xinetd.d/*; then
    echo "chargen services are active. Please disable them."
  else
    echo "chargen services are not active. OK."
  fi
}


check_daytime_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "daytime" /etc/xinetd.d/*; then
    echo "daytime services are active. Please disable them."
  else
    echo "daytime services are not active. OK."
  fi
}


check_discard_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "discard" /etc/xinetd.d/*; then
    echo "discard services are active. Please disable them."
  else
    echo "discard services are not active. OK."
  fi
}


check_echo_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "echo" /etc/xinetd.d/*; then
    echo "echo services are active. Please disable them."
  else
    echo "echo services are not active. OK."
  fi
}


check_time_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "time" /etc/xinetd.d/*; then
    echo "time services are active. Please disable them."
  else
    echo "time services are not active. OK."
  fi
}


check_rsh_server() {
  if systemctl is-active rsh.socket &> /dev/null || systemctl is-active rlogin.socket &> /dev/null || systemctl is-active rexec.socket &> /dev/null; then
    echo "rsh server is active. Please disable it."
  else
    echo "rsh server is not active. OK."
  fi
}


check_talk_server() {
  if systemctl is-active talk &> /dev/null; then
    echo "talk server is active. Please disable it."
  else
    echo "talk server is not active. OK."
  fi
}


check_tftp_server() {
  if systemctl is-active tftp.socket &> /dev/null; then
    echo "tftp server is active. Please disable it."
  else
    echo "tftp server is not active. OK."
  fi
}


check_rsync_service() {
  if systemctl is-active rsyncd &> /dev/null; then
    echo "rsync service is active. Please disable it."
  else
    echo "rsync service is not active. OK."
  fi
}


check_xinetd_service() {
  if systemctl is-active xinetd &> /dev/null; then
    echo "xinetd service is active. Please disable it."
  else
    echo "xinetd service is not active. OK."
  fi
}


check_chargen_services
check_daytime_services
check_discard_services
check_echo_services
check_time_services
check_rsh_server
check_talk_server
check_tftp_server
check_rsync_service
check_xinetd_service
