#!/bin/bash


disable_chargen_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "chargen" /etc/xinetd.d/*; then
    sed -i 's/disable\s*=\s*no/disable = yes/' /etc/xinetd.d/chargen
    systemctl restart xinetd
    echo "chargen services have been disabled."
  else
    echo "chargen services are already disabled or xinetd is not active."
  fi
}


disable_daytime_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "daytime" /etc/xinetd.d/*; then
    sed -i 's/disable\s*=\s*no/disable = yes/' /etc/xinetd.d/daytime
    systemctl restart xinetd
    echo "daytime services have been disabled."
  else
    echo "daytime services are already disabled or xinetd is not active."
  fi
}


disable_discard_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "discard" /etc/xinetd.d/*; then
    sed -i 's/disable\s*=\s*no/disable = yes/' /etc/xinetd.d/discard
    systemctl restart xinetd
    echo "discard services have been disabled."
  else
    echo "discard services are already disabled or xinetd is not active."
  fi
}


disable_echo_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "echo" /etc/xinetd.d/*; then
    sed -i 's/disable\s*=\s*no/disable = yes/' /etc/xinetd.d/echo
    systemctl restart xinetd
    echo "echo services have been disabled."
  else
    echo "echo services are already disabled or xinetd is not active."
  fi
}


disable_time_services() {
  if systemctl is-active xinetd &> /dev/null && grep -q "time" /etc/xinetd.d/*; then
    sed -i 's/disable\s*=\s*no/disable = yes/' /etc/xinetd.d/time
    systemctl restart xinetd
    echo "time services have been disabled."
  else
    echo "time services are already disabled or xinetd is not active."
  fi
}


disable_rsh_server() {
  systemctl disable rsh.socket rlogin.socket rexec.socket
  systemctl stop rsh.socket rlogin.socket rexec.socket
  echo "rsh server has been disabled."
}


disable_talk_server() {
  systemctl disable talk
  systemctl stop talk
  echo "talk server has been disabled."
}


disable_tftp_server() {
  systemctl disable tftp.socket
  systemctl stop tftp.socket
  echo "tftp server has been disabled."
}


disable_rsync_service() {
  systemctl disable rsyncd
  systemctl stop rsyncd
  echo "rsync service has been disabled."
}


disable_xinetd_service() {
  systemctl disable xinetd
  systemctl stop xinetd
  echo "xinetd service has been disabled."
}


disable_chargen_services
disable_daytime_services
disable_discard_services
disable_echo_services
disable_time_services
disable_rsh_server
disable_talk_server
disable_tftp_server
disable_rsync_service
disable_xinetd_service
