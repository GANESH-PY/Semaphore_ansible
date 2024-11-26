#!/bin/bash
set -e  # Exit on error

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
sudo useradd -m -s /bin/bash -c "$fullname" "$username" || { echo "Failed to create user"; exit 1; }

# Set password for the non_sudo_user
echo "$username:$password" | sudo chpasswd || { echo "Failed to set password"; exit 1; }

# Set fsuser to not require password for sudo
echo "fsuser  ALL=(ALL)  NOPASSWD: ALL" | sudo tee /etc/sudoers.d/fsuser > /dev/null || { echo "Failed to set sudoers"; exit 1; }

# Add ssh key
mkdir -p /home/fsuser/.ssh || { echo "Failed to create .ssh directory"; exit 1; }
chmod 700 /home/fsuser/.ssh

touch /home/fsuser/.ssh/authorized_keys || { echo "Failed to create authorized_keys"; exit 1; }
chmod 600 /home/fsuser/.ssh/authorized_keys

key="ssh-rsa AAAAB3Nza...fsuser@FS-SRV-IN-04"
echo $key > /home/fsuser/.ssh/authorized_keys || { echo "Failed to write SSH key"; exit 1; }

chown -R fsuser:fsuser /home/fsuser/.ssh || { echo "Failed to set ownership"; exit 1; }

echo "User setup complete"
