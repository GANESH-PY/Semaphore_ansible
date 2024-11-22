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
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3RWItgvuZK3rVgONZXQ3zlNF1bdn4YfR67RiUVONH9UU9B6+YwCou94y5SOZ+QTR2dWrjS6k8Yh1UDrFKjd9J8dHR4F9hcxw8O5ilfPzhttgDWoMu0Ex+HHMgy+7eOvtZAqqbeLpRocmw/LOJSDcXlRPq/ZTQvvkThjyYjM18TnhURbzDHyUB2cTmhFy8HMpioPaxdYmr7J3brKZoxn7utWayeMDEwqY47ot+exFohf0ZkAHLp5shcdNexlRgVkf2p6gMwsc/KP9tjaOeeR9QKzWYSCROTUUFZMecHnVpaoieDIGmRO5yP5t0hj7HWI0xadm/Nw/bXrtnBMToiEJw0u3H/v6vpBh80oO0xnY4xuOxZAX7TOjnjOKkUvAHEHv4vASw1F2wowFYysN3BIlWmOtP4HJxdi8VJqXlIVH8tO4v/yE8dYTm5KVoohKMX0YiHvxKWgtrF907WBEINOnLVlN0E0GjvU3fiDaSkpSfyQolgvtMhdj2/07IeAXwOuLhd4ZWkdxy67iJ5Qdyc42JeTG1sx1sUUAF4BZNf+s64aK9jsky2hX9yxKhMcmydsS3bLYHCsaEiKNyuVcC2nyWdOj6xqKlsLsmayJer3F4VjwxelSNp1MzArvXz+vds2DXk5+wT0WavkmaSMihnblTSyTli9TpKm2LOFUYfnAsgw== fsuser@FS-SRV-IN-04"
chmod 700 /home/fsuser/.ssh/
chmod 600 /home/fsuser/.ssh/authorized_keys
echo $key > /home/fsuser/.ssh/authorized_keys
chown -R fsuser:fsuser /home/fsuser/.ssh