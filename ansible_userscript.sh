#!/bin/bash

# Set user variables
USER="ansible"
PASSWORD="finsurge@123"
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYRVadvilhikBIJZ14OQiMB/nts5db3kXSlOBfl2z49gq1PnGjBLFG5/4m3qTlfPLe+R00R6fMIgFqh75t0MMpCDrCoP+QffzijkecBhfBAyi7/V+BuoI7xcC7B8om2MVXqMB10WiTng20vzN2sio8T/WovY1MuWtc3PyZrNa18CzV3lH+RGPCJhIelCot6KKD8dyZaiWfQ1Las9w+9aMFykSBC/uG3jMOVmOmXXYCGfRN285q6JkTP3SA/3BOar4lRWFXtde9+x3BEVqR0CxfpNHl4gLXlkbqAD0L5pnJ0FCNtzMhPLvXRuiKFpozoMs+FsffQdIknb+bKoJBEunT fsuser@FS-DEV-L-IN-045"

# 1. Create the user 'ansible' with the specified password
echo "Creating user $USER..."
sudo useradd -m $USER
echo "$USER:$PASSWORD" | sudo chpasswd

# 2. Add the user to the sudo group to grant sudo permissions
echo "Granting sudo permissions to $USER..."
sudo usermod -aG sudo $USER

# 3. Create the SSH directory for the user and set proper permissions
echo "Creating SSH directory for $USER..."
sudo mkdir -p /home/$USER/.ssh
sudo chmod 700 /home/$USER/.ssh

# 4. Add the SSH public key to the authorized_keys file
echo "Adding SSH public key to authorized_keys..."
echo "$PUBLIC_KEY" | sudo tee /home/$USER/.ssh/authorized_keys > /dev/null

# 5. Set proper permissions for the authorized_keys file
echo "Setting permissions for authorized_keys..."
sudo chmod 600 /home/$USER/.ssh/authorized_keys
sudo chown -R $USER:$USER /home/$USER/.ssh

# 6. Verify sudo permissions for the user
echo "Verifying sudo permissions for $USER..."
sudo -u $USER sudo -l

echo "User $USER has been successfully created with sudo permissions and SSH access!"
