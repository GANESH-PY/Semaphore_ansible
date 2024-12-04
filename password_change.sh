#!/usr/bin/env bash

user_name="fsuser"
user_password="Kingsoft@77"
echo "$user_name:$user_password" | sudo chpasswd

rm -- "$0"
