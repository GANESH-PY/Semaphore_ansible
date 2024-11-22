#!/bin/bash

# This script sets up the user and configures SSH key authentication for fsuser.

# Exit immediately if a command exits with a non-zero status.
set -e

# Argument: hostname
hostname=$1

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Ensure the .ssh directory exists
mkdir -p /home/fsuser/.ssh

# Create the authorized_keys file if it doesn't exist
touch /home/fsuser/.ssh/authorized_keys

# Define the SSH public key (replace with your actual key)
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYRVadvilhikBIJZ14OQiMB/nts5db3kXSlOBfl2z49gq1PnGjBLFG5/4m3qTlfPLe+R00R6fMIgFqh75t0MMpCDrCoP+QffzijkecBhfBAyi7/V+BuoI7xcC7B8om2MVXqMB10WiTng20vzN2sio8T/WovY1MuWtc3PyZrNa18CzV3lH+RGPCJhIelCot6KKD8dyZaiWfQ1Las9w+9aMFykSBC/uG3jMOVmOmXXYCGfRN285q6JkTP3SA/3BOar4lRWFXtde9+x3BEVqR0CxfpNHl4gLXlkbqAD0L5pnJ0FCNtzMhPLvXRuiKFpozoMs+FsffQdIknb+bKoJBEunT fsuser@FS-DEV-L-IN-045"

# Check if the key is already in authorized_keys, if not, append it
if ! grep -q "$key" /home/fsuser/.ssh/authorized_keys; then
  echo "$key" >> /home/fsuser/.ssh/authorized_keys
fi

# Set the correct permissions for the .ssh directory and authorized_keys file
chmod 700 /home/fsuser/.ssh
chmod 600 /home/fsuser/.ssh/authorized_keys

# Change ownership to the fsuser user
chown -R fsuser:fsuser /home/fsuser/.ssh

# Output the current hostname for verification
echo "Setup complete for $hostname"
