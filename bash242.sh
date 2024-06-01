#!/bin/bash


check_user_home_directories() {
  missing_home_dirs=$(awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false" && !system("test -d " $6)) {print $1}' /etc/passwd)
  if [ -z "$missing_home_dirs" ]; then
    echo "All user home directories exist. OK."
  else
    echo "Missing home directories for the following users:"
    echo "$missing_home_dirs"
  fi
}


check_home_directory_permissions() {
  bad_permissions=$(awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false" && system("test -d " $6 " && test $(stat -c %a " $6 ") -le 750")) {print $1}' /etc/passwd)
  if [ -z "$bad_permissions" ]; then
    echo "All user home directory permissions are restrictive enough. OK."
  else
    echo "The following users have home directories with too permissive permissions:"
    echo "$bad_permissions"
  fi
}


check_dot_file_permissions() {
  bad_dot_files=$(find /home -type f -name '.*' -perm /g+w)
  if [ -z "$bad_dot_files" ]; then
    echo "No dot files with group write permissions found. OK."
  else
    echo "The following dot files have group write permissions:"
    echo "$bad_dot_files"
  fi
}


check_forward_files() {
  forward_files=$(find /home -type f -name '.forward')
  if [ -z "$forward_files" ]; then
    echo "No .forward files found. OK."
  else
    echo "The following users have .forward files:"
    echo "$forward_files"
  fi
}


check_netrc_files() {
  netrc_files=$(find /home -type f -name '.netrc')
  if [ -z "$netrc_files" ]; then
    echo "No .netrc files found. OK."
  else
    echo "The following users have .netrc files:"
    echo "$netrc_files"
  fi
}


check_rhosts_files() {
  rhosts_files=$(find /home -type f -name '.rhosts')
  if [ -z "$rhosts_files" ]; then
    echo "No .rhosts files found. OK."
  else
    echo "The following users have .rhosts files:"
    echo "$rhosts_files"
  fi
}


check_groups_in_passwd_and_group() {
  passwd_groups=$(awk -F: '{print $4}' /etc/passwd | sort -u)
  group_groups=$(awk -F: '{print $3}' /etc/group | sort -u)
  missing_groups=$(comm -23 <(echo "$passwd_groups") <(echo "$group_groups"))
  if [ -z "$missing_groups" ]; then
    echo "All groups in /etc/passwd exist in /etc/group. OK."
  else
    echo "The following groups from /etc/passwd are missing in /etc/group:"
    echo "$missing_groups"
  fi
}


check_duplicate_uids() {
  duplicate_uids=$(awk -F: '{print $3}' /etc/passwd | sort | uniq -d)
  if [ -z "$duplicate_uids" ]; then
    echo "No duplicate UIDs found. OK."
  else
    echo "Duplicate UIDs found:"
    echo "$duplicate_uids"
  fi
}


check_duplicate_gids() {
  duplicate_gids=$(awk -F: '{print $3}' /etc/group | sort | uniq -d)
  if [ -z "$duplicate_gids" ]; then
    echo "No duplicate GIDs found. OK."
  else
    echo "Duplicate GIDs found:"
    echo "$duplicate_gids"
  fi
}


check_duplicate_usernames() {
  duplicate_usernames=$(awk -F: '{print $1}' /etc/passwd | sort | uniq -d)
  if [ -z "$duplicate_usernames" ]; then
    echo "No duplicate usernames found. OK."
  else
    echo "Duplicate usernames found:"
    echo "$duplicate_usernames"
  fi
}


check_duplicate_groupnames() {
  duplicate_groupnames=$(awk -F: '{print $1}' /etc/group | sort | uniq -d)
  if [ -z "$duplicate_groupnames" ]; then
    echo "No duplicate group names found. OK."
  else
    echo "Duplicate group names found:"
    echo "$duplicate_groupnames"
  fi
}


check_empty_shadow_group() {
  shadow_group_members=$(getent group shadow | awk -F: '{print $4}')
  if [ -z "$shadow_group_members" ]; then
    echo "Shadow group is empty. OK."
  else
    echo "Shadow group is not empty:"
    echo "$shadow_group_members"
  fi
}


check_user_home_directories
check_home_directory_permissions
check_dot_file_permissions
check_forward_files
check_netrc_files
check_rhosts_files
check_groups_in_passwd_and_group
check_duplicate_uids
check_duplicate_gids
check_duplicate_usernames
check_duplicate_groupnames
check_empty_shadow_group
