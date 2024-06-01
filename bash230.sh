#!/bin/bash


check_suid_files() {
  suid_files=$(find / -perm -4000 -type f 2>/dev/null)
  if [ -n "$suid_files" ]; then
    echo "SUID files found:"
    echo "$suid_files"
  else
    echo "No SUID files found. OK."
  fi
}


check_sgid_files() {
  sgid_files=$(find / -perm -2000 -type f 2>/dev/null)
  if [ -n "$sgid_files" ]; then
    echo "SGID files found:"
    echo "$sgid_files"
  else
    echo "No SGID files found. OK."
  fi
}


check_shadow_passwords() {
  if grep -q '^[^:]*:[^!*]' /etc/passwd; then
    echo "Not all accounts in /etc/passwd are using shadowed passwords."
  else
    echo "All accounts in /etc/passwd are using shadowed passwords. OK."
  fi
}


check_non_empty_shadow_passwords() {
  if grep -q '^[^:]*:[!*]' /etc/shadow; then
    echo "There are empty password fields in /etc/shadow."
  else
    echo "No empty password fields in /etc/shadow. OK."
  fi
}


check_old_plus_entries_passwd() {
  if grep -q '^\+:' /etc/passwd; then
    echo "Old '+' entries found in /etc/passwd."
  else
    echo "No old '+' entries in /etc/passwd. OK."
  fi
}


check_old_plus_entries_shadow() {
  if grep -q '^\+:' /etc/shadow; then
    echo "Old '+' entries found in /etc/shadow."
  else
    echo "No old '+' entries in /etc/shadow. OK."
  fi
}


check_old_plus_entries_group() {
  if grep -q '^\+:' /etc/group; then
    echo "Old '+' entries found in /etc/group."
  else
    echo "No old '+' entries in /etc/group. OK."
  fi
}


check_root_uid() {
  if [ "$(awk -F: '($3 == 0) {print}' /etc/passwd | wc -l)" -eq 1 ]; then
    echo "root is the only account with UID 0. OK."
  else
    echo "There are multiple accounts with UID 0."
  fi
}


check_root_path_integrity() {
  if [[ ":$PATH:" == *":."* || ":$PATH:" == *":/sbin:"* || ":$PATH:" == *":/usr/sbin:"* || ":$PATH:" == *":/bin:"* ]]; then
    echo "Root PATH integrity is ensured. OK."
  else
    echo "Root PATH integrity is not ensured."
  fi
}


check_user_home_directories() {
  missing_home_dirs=$(awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false" && !system("test -d " $6)) {print $1}' /etc/passwd)
  if [ -z "$missing_home_dirs" ]; then
    echo "All user home directories exist. OK."
  else
    echo "Missing home directories for the following users:"
    echo "$missing_home_dirs"
  fi
}


check_suid_files
check_sgid_files
check_shadow_passwords
check_non_empty_shadow_passwords
check_old_plus_entries_passwd
check_old_plus_entries_shadow
check_old_plus_entries_group
check_root_uid
check_root_path_integrity
check_user_home_directories
