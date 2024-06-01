#!/bin/bash


create_missing_home_directories() {
  for dir in $(awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false" && !system("test -d " $6)) {print $6}' /etc/passwd); do
    mkdir -p "$dir"
    chown $(awk -F: -v home_dir="$dir" '($6 == home_dir) {print $1":"$1}' /etc/passwd) "$dir"
    chmod 750 "$dir"
    echo "Created missing home directory: $dir with permissions 750"
  done
}


set_home_directory_permissions() {
  for dir in $(awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") {print $6}' /etc/passwd); do
    chmod 750 "$dir"
    echo "Set permissions for home directory: $dir to 750"
  done
}


remove_group_write_permissions_dot_files() {
  find /home -type f -name '.*' -perm /g+w -exec chmod g-w {} \;
  echo "Removed group write permissions from dot files."
}


remove_forward_files() {
  find /home -type f -name '.forward' -exec rm -f {} \;
  echo "Removed .forward files."
}


remove_netrc_files() {
  find /home -type f -name '.netrc' -exec rm -f {} \;
  echo "Removed .netrc files."
}


remove_rhosts_files() {
  find /home -type f -name '.rhosts' -exec rm -f {} \;
  echo "Removed .rhosts files."
}


add_missing_groups() {
  for group in $(awk -F: '{print $4}' /etc/passwd | sort -u); do
    if ! getent group "$group" > /dev/null; then
      groupadd "$group"
      echo "Added missing group: $group"
    fi
  done
}


fix_duplicate_uids() {
  for uid in $(awk -F: '{print $3}' /etc/passwd | sort | uniq -d); do
    user=$(awk -F: -v uid="$uid" '($3 == uid) {print $1}' /etc/passwd | head -n 1)
    usermod -u $((uid + 1000)) "$user"
    echo "Changed UID for user $user to $((uid + 1000))"
  done
}


fix_duplicate_gids() {
  for gid in $(awk -F: '{print $3}' /etc/group | sort | uniq -d); do
    group=$(awk -F: -v gid="$gid" '($3 == gid) {print $1}' /etc/group | head -n 1)
    groupmod -g $((gid + 1000)) "$group"
    echo "Changed GID for group $group to $((gid + 1000))"
  done
}


fix_duplicate_usernames() {
  for username in $(awk -F: '{print $1}' /etc/passwd | sort | uniq -d); do
    usermod -l "${username}_duplicate" "$username"
    echo "Changed username $username to ${username}_duplicate"
  done
}


fix_duplicate_groupnames() {
  for groupname in $(awk -F: '{print $1}' /etc/group | sort | uniq -d); do
    groupmod -n "${groupname}_duplicate" "$groupname"
    echo "Changed group name $groupname to ${groupname}_duplicate"
  done
}


empty_shadow_group() {
  gpasswd -d $(gpasswd -M "" shadow)
  echo "Emptied shadow group."
}


create_missing_home_directories
set_home_directory_permissions
remove_group_write_permissions_dot_files
remove_forward_files
remove_netrc_files
remove_rhosts_files
add_missing_groups
fix_duplicate_uids
fix_duplicate_gids
fix_duplicate_usernames
fix_duplicate_groupnames
empty_shadow_group
