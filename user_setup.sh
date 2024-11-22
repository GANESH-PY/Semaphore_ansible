#!/bin/bash

# Define the SSH public key
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3RWItgvuZK3rVgONZXQ3zlNF1bdn4YfR67RiUVONH9UU9B6+YwCou94y5SOZ+QTR2dWrjS6k8Yh1UDrFKjd9J8dHR4F9hcxw8O5ilfPzhttgDWoMu0Ex+HHMgy+7eOvtZAqqbeLpRocmw/LOJSDcXlRPq/ZTQvvkThjyYjM18TnhURbzDHyUB2cTmhFy8HMpioPaxdYmr7J3brKZoxn7utWayeMDEwqY47ot+exFohf0ZkAHLp5shcdNexlRgVkf2p6gMwsc/KP9tjaOeeR9QKzWYSCROTUUFZMecHnVpaoieDIGmRO5yP5t0hj7HWI0xadm/Nw/bXrtnBMToiEJw0u3H/v6vpBh80oO0xnY4xuOxZAX7TOjnjOKkUvAHEHv4vASw1F2wowFYysN3BIlWmOtP4HJxdi8VJqXlIVH8tO4v/yE8dYTm5KVoohKMX0YiHvxKWgtrF907WBEINOnLVlN0E0GjvU3fiDaSkpSfyQolgvtMhdj2/07IeAXwOuLhd4ZWkdxy67iJ5Qdyc42JeTG1sx1sUUAF4BZNf+s64aK9jsky2hX9yxKhMcmydsS3bLYHCsaEiKNyuVcC2nyWdOj6xqKlsLsmayJer3F4VjwxelSNp1MzArvXz+vds2DXk5+wT0WavkmaSMihnblTSyTli9TpKm2LOFUYfnAsgw== fsuser@FS-SRV-IN-04"

# Define the user's home directory
user_home="/home/fsuser"

# Ensure the .ssh directory exists
if [ ! -d "$user_home/.ssh" ]; then
    echo "Creating .ssh directory for fsuser"
    mkdir -p "$user_home/.ssh"
    chmod 700 "$user_home/.ssh"
fi

# Add the SSH key to the authorized_keys file
echo "$key" >> "$user_home/.ssh/authorized_keys"

# Set the correct permissions for the authorized_keys file
chmod 600 "$user_home/.ssh/authorized_keys"

# Change the ownership to fsuser
chown -R fsuser:fsuser "$user_home/.ssh"

echo "SSH key has been added to /home/fsuser/.ssh/authorized_keys"
