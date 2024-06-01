#!/bin/bash


remove_suid() {
  find / -perm -4000 -type f -exec chmod u-s {} \;
  echo "Removed SUID from all files."
}


remove_sgid() {
  find / -perm -2000 -type f -exec chmod g-s {} \;
  echo "Removed SGID from all files."
}


move_to_shadow_passwords() {
  pwconv
  echo "All accounts moved to use shadowed passwords."
}


remove_old_plus_entries_passwd() {
  sed -i '/^\+:/d' /etc/passwd
  echo "Removed old '+' entries from /etc/passwd."
}


remove_old_plus_entries_shadow() {
  sed -i '/^\+:/d' /etc/shadow
  echo "Removed old '+' entries from /etc/shadow."
}


remove_old_plus_entries_group() {
  sed -i '/^\+:/d' /etc/group
  echo "Removed old '+' entries from /etc/group."
}


ensure_single_root_uid() {
  awk -F: '($3 == 0 && $1 != "root") { $3 = "1000"; print > "/etc/passwd.tmp" }' /etc/passwd
  mv /etc/passwd.tmp /etc/passwd
  echo "Ensured root is the only account with UID 0."
}


ensure_root_path_integrity() {
  if [[ ":$PATH:" != *":."* && ":$PATH:" != *":/sbin:"* && ":$PATH:" != *":/usr/sbin:"* && ":$PATH:" != *":/bin:"* ]]; then
    export PATH="/sbin:/usr/sbin:/bin:$PATH"
    echo "Root PATH integrity ensured."
  else
    echo "Root PATH integrity already ensured."
  fi
}


create_missing_home_directories() {
  for dir in $(awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false" && !system("test -d " $6)) {print $6}' /etc/passwd); do
    mkdir -p "$dir"
    chown $(awk -F: -v home_dir="$dir" '($6 == home_dir) {print $1":"$1}' /etc/passwd) "$dir"
    echo "Created missing home directory: $dir"
  done
}


remove_suid
remove_sgid
move_to_shadow_passwords
remove_old_plus_entries_passwd
remove_old_plus_entries_shadow
remove_old_plus_entries_group
ensure_single_root_uid
ensure_root_path_integrity
create_missing_home_directories
