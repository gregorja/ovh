#! /bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt install nano dnsutils htop uptimed fail2ban ufw -y

sudo timedatectl set-timezone America/New_York

sudo ufw --force disable && sudo ufw --force reset && sudo ufw default deny incoming && \
   sudo ufw default allow outgoing && sudo ufw allow from any to any port 22 proto tcp && sudo ufw --force enable

sudo systemctl is-active --quiet uptimed || sudo systemctl start fail2ban && sudo systemctl start fail2ban

sudo systemctl is-active --quiet uptimed || sudo systemctl start uptimed && sudo systemctl enable uptimed

timedatectl >> status_checker.txt

sudo uprecords >> status_checker.txt

lscpu >> status_checker.txt

free -mh >> status_checker.txt

df -H >> status_checker.txt

lsblk >> status_checker.txt

sudo fail2ban-client status sshd >> status_checker.txt

sudo ufw status verbose >> status_checker.txt

echo "======================================NEXT=============================" >> status_checker.txt

cat status_checker.txt
