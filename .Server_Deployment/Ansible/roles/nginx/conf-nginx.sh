#!/bin/bash

# Creates certificates to use for securing the webapp
sudo mkdir /etc/nginx/certificate
sudo cd /etc/nginx/certificate
sudo openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -subj "/C=RU/ST=Tarstan/L=Innopolis/O=Innopolis University/CN=IU" \
    -out nginx-certificate.crt -keyout nginx.key

# Download the recquired config file for creating nginx host
cd
#wget https://github.com/SNE22-INNOPOLIS/LS-Exam/blob/dev/.Server_Deployment/Ansible/roles/nginx/tls-config
sudo touch /etc/nginx/sites-available/ls-exam-app.conf

# create a symlink to enable the webapp host
sudo ln -s /etc/nginx/sites-available/ls-exam-app.conf /etc/nginx/sites-enabled/

# write the downloaded config to the app host
sudo cat tls-config > /etc/nginx/sites-available/ls-exam-app.conf

# restart nginx
sudo systemctl restart nginx.service