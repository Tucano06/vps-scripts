#!/bin/bash
#OVH's Securing guide section
sudo apt update && sudo apt upgrade -y
read -p "Enter the custom SSH port you want to allow in UFW (or press Enter to use the default "22"): " SSH_PORT
SSH_PORT=${SSH_PORT:-22}
sudo vim /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo vim /lib/systemd/system/ssh.socket
sudo systemctl daemon-reload
sudo systemctl restart ssh.service
sudo apt install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo vim /etc/fail2ban/jail.local
sudo systemctl restart fail2ban
#Tecmint's Securing guide section
sudo apt install ufw -y 
sudo ufw status verbose
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw app list
sudo ufw allow ssh
sudo ufw allow $SSH_PORT/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
if [[ $SSH_PORT != "22" ]]; then
	sudo ufw delete allow 22/tcp
fi
sudo ufw status
