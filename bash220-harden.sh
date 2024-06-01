#!/bin/bash


configure_passwd_dash_permissions() {
  chmod 600 /etc/passwd-
  echo "Permissions for /etc/passwd- configured."
}


configure_group_permissions() {
  chmod 644 /etc/group
  echo "Permissions for /etc/group configured."
}


configure_group_dash_permissions() {
  chmod 600 /etc/group-
  echo "Permissions for /etc/group- configured."
}


configure_shadow_permissions() {
  chmod 000 /etc/shadow
  echo "Permissions for /etc/shadow configured."
}


configure_shadow_dash_permissions() {
  chmod 600 /etc/shadow-
  echo "Permissions for /etc/shadow- configured."
}


configure_gshadow_permissions() {
  chmod 000 /etc/gshadow
  echo "Permissions for /etc/gshadow configured."
}


configure_gshadow_dash_permissions() {
  chmod 600 /etc/gshadow-
  echo "Permissions for /etc/gshadow- configured."
}


remove_world_writable_files() {
  find / -xdev -type f -perm -0002 -exec chmod o-w {} \;
  echo "World writable files permissions removed."
}


remove_unowned_files_and_dirs() {
  find / -xdev \( -nouser -o -nogroup \) -exec chown root:root {} \;
  echo "Unowned files or directories ownership set to root."
}


configure_passwd_dash_permissions
configure_group_permissions
configure_group_dash_permissions
configure_shadow_permissions
configure_shadow_dash_permissions
configure_gshadow_permissions
configure_gshadow_dash_permissions
remove_world_writable_files
remove_unowned_files_and_dirs
