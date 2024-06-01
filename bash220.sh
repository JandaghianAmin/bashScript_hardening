#!/bin/bash


check_passwd_dash_permissions() {
  if [ "$(stat -c %a /etc/passwd-)" == "600" ]; then
    echo "Permissions for /etc/passwd- are configured. OK."
  else
    echo "Permissions for /etc/passwd- are not configured."
  fi
}


check_group_permissions() {
  if [ "$(stat -c %a /etc/group)" == "644" ]; then
    echo "Permissions for /etc/group are configured. OK."
  else
    echo "Permissions for /etc/group are not configured."
  fi
}


check_group_dash_permissions() {
  if [ "$(stat -c %a /etc/group-)" == "600" ]; then
    echo "Permissions for /etc/group- are configured. OK."
  else
    echo "Permissions for /etc/group- are not configured."
  fi
}


check_shadow_permissions() {
  if [ "$(stat -c %a /etc/shadow)" == "000" ]; then
    echo "Permissions for /etc/shadow are configured. OK."
  else
    echo "Permissions for /etc/shadow are not configured."
  fi
}


check_shadow_dash_permissions() {
  if [ "$(stat -c %a /etc/shadow-)" == "600" ]; then
    echo "Permissions for /etc/shadow- are configured. OK."
  else
    echo "Permissions for /etc/shadow- are not configured."
  fi
}


check_gshadow_permissions() {
  if [ "$(stat -c %a /etc/gshadow)" == "000" ]; then
    echo "Permissions for /etc/gshadow are configured. OK."
  else
    echo "Permissions for /etc/gshadow are not configured."
  fi
}


check_gshadow_dash_permissions() {
  if [ "$(stat -c %a /etc/gshadow-)" == "600" ]; then
    echo "Permissions for /etc/gshadow- are configured. OK."
  else
    echo "Permissions for /etc/gshadow- are not configured."
  fi
}


check_world_writable_files() {
  if [ -z "$(find / -xdev -type f -perm -0002 -print)" ]; then
    echo "No world writable files found. OK."
  else
    echo "World writable files found."
  fi
}


check_unowned_files_and_dirs() {
  if [ -z "$(find / -xdev \( -nouser -o -nogroup \) -print)" ]; then
    echo "No unowned files or directories found. OK."
  else
    echo "Unowned files or directories found."
  fi
}


check_passwd_dash_permissions
check_group_permissions
check_group_dash_permissions
check_shadow_permissions
check_shadow_dash_permissions
check_gshadow_permissions
check_gshadow_dash_permissions
check_world_writable_files
check_unowned_files_and_dirs
