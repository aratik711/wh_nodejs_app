#!/bin/bash

USER=$1
USER_PASS=$2
HOSTNAME=$3

echo $HOSTNAME

echo "Add user compose"
sudo adduser --disabled-password --gecos "" $USER

echo "Set Password for user $USER"
echo "$USER:$USER_PASS" | sudo chpasswd

echo "Add user compose in sudoers file"
sudo sed -i '$a'$USER' ALL=(ALL)  ALL' /etc/sudoers

echo "Add passwordless sudo"
sudo sed -i '$a'$USER' ALL=(ALL) NOPASSWD:ALL' /etc/sudoers

echo "update the /etc/hostname file with the new hostname/fqdn"
CURR_HOSTNAME=$(cat /etc/hostname)
sudo sed -i "s/$CURR_HOSTNAME/$HOSTNAME/g" /etc/hostname

echo "Add entry in hosts file"
sudo sed -i '$a127.0.0.1 '$HOSTNAME'' /etc/hosts

echo "Restart login service"
sudo systemctl restart systemd-logind.service

echo "update the running hostname"
sudo hostnamectl set-hostname $HOSTNAME

echo "Install SSH server and client"
sudo apt-get -y install openssh-server openssh-client

echo "Enable user login via password"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config


echo "Restart ssh service"
sudo service sshd restart

echo "SSH keygen command"
echo y |sudo su $USER -c 'ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""'

echo "Install expect for passwordless ssh"
sudo apt-get -y install expect

echo "Install git"
sudo apt-get -y install git
