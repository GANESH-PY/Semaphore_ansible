#!/bin/bash


cat <<EOF > "/etc/sudoers.d/fsuser"
fsuser  ALL=(ALL)  NOPASSWD: ALL
EOF

#Add ssh key
mkdir /home/fsuser/.ssh
touch /home/fsuser/.ssh/authorized_keys
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC49zn7EROmvwF7ou3I3qGECqdhoTK3k+fM7JgxaA/e5xCtS/asStwn/27mqCJbpZSCk0yqm3oFnHrhkwRJI60b+pp7C3GXTblc6U2ZK+pedR7paL6BWK18j3uWT5PP31hnlG3+2RN0khl98NpM/n4NSf28Na0kE8EilTpFUl8wDQlsu+Iovz6T5vWcYLqDtnxcs9D4otQBZViMKZU4DK+X9ers64Oi8NyLuQHaZJC3sr0GJHWR9hOEc2y7UJVXERropc2ON7wUjc4tv87+LMcoh6aBhNcippn58gFb3sGbE/j7ehpMP+CMYvQfbjPsRetkUWp7JZpNISKy2nxDSrC3M+eux0J7iDhBr0q2H62XYwf85q32GnSGfyZh1QaFkGo3A89a93s5WUNOeSh9x27VlpK1JAVJz4Yg/OkRSSyCsfrptrHXtgeIxyPy37ya7gIBw4YVN4VhE8lVPXzbq3FdXl+6A97pDA8YJriQt0g/i/JraH0HDvU6AYg/W1GzKAk= fsuser@FS-SRV-IN-05"
chmod 700 /home/fsuser/.ssh/
chmod 600 /home/fsuser/.ssh/authorized_keys
echo $key > /home/fsuser/.ssh/authorized_keys
chown -R fsuser:fsuser /home/fsuser/.ssh
