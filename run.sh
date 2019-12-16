#!/bin/sh
mkdir -p /root/.ssh
cp /root/ssh-key/id_rsa* /root/.ssh
echo "" >> /root/.ssh/id_rsa
echo "" >> /root/.ssh/id_rsa.pub
chmod 400 /root/.ssh/id_rsa*
if [ "$1" = "stats" ]; then
    ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no $3@$2 'bash -s' < /opt/usg-blacklist/stats.sh
else
    ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no $3@$2 'bash -s' < /opt/usg-blacklist/blacklist.sh
fi