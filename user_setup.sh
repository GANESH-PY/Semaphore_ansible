#!/bin/bash

# Check if full name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <full_name>"
    exit 1
fi

# Extract full name from command-line argument
fullname="$(echo "$1" | sed 's/_/ /g')"
password="finsurge@123"

# Extract user name from full name and convert to lowercase
username=$(echo "$fullname" | cut -d ' ' -f 1 | tr '[:upper:]' '[:lower:]')

# Create user with home directory and set full name for login and username for user
sudo useradd -m -s /bin/bash -c "$fullname" "$username"

# Set password for the non_sudo_user
echo "$username:$password" | sudo chpasswd

#Set fsuser to not require password for sudo
cat <<EOF > "/etc/sudoers.d/fsuser"
fsuser  ALL=(ALL)  NOPASSWD: ALL
EOF

#Add ssh key
mkdir /home/fsuser/.ssh
touch /home/fsuser/.ssh/authorized_keys
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOMlJVvLi05BidwKrVB+ZkNrhD0FSYnXMgdv+KY7tzK/2s7cUv46tL/SsRShF3k/oGGsIIMemiSY7udL8lHYZJSxSBa5HAwMaxsRf8LZUxKLLSSf7unn14bkASLZvqlk55ZZYG87HySoAqtLI6uFbTDa63vueAr/gqaA65C824JJPDW1r8PeJXxhQE7kK3qNZV09ukHjav0ye/pNlE9ZkBhcSXYQejSTcd6efEcArnFGctbMiBYsp0is3Jrupj44F7pI6tLx/7/9U+/d4PY9vmWi99nRZmdFRfzwN5hfWRevOmzCJ1Wlb0E5Ge9BD1Rd+lvLHMilWUyXw6lHaqgDMVc5QiOSIsx8Awv55Y6tTZBG8u/PhUTQsdg0yAZz4aw7eYC7S3dgqX632IrQbsH0ZsLUsQNfH68tNpg8Dh1PLMCViI8B0EHZtHCu/gdQ+31P9NtR2Tw4iF/A3XoK0SjfYFexo5yInLZLk4CeU1iZymTv+rZ8kR01RKBCwKD2pgl40= fsuser@mail"
chmod 700 /home/fsuser/.ssh/
chmod 600 /home/fsuser/.ssh/authorized_keys
echo $key > /home/fsuser/.ssh/authorized_keys
chown -R fsuser:fsuser /home/fsuser/.ssh
