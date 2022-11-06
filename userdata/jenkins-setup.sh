#!/bin/bash
sudo apt update
sudo apt install openjdk-8-jdk -y
sudo apt install ca-certificates -y
sudo apt install maven git wget unzip -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

# nginx installation for reverse proxy
apt-get install nginx -y
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default
cat <<EOT> /etc/nginx/sites-available/jenkins
proxy_cache_path /tmp/nginx_cache/ keys_zone=name:10m;

upstream jenkin {
  ip_hash;
  server localhost:8080;
}

server{
    listen 80;
    listen [::]:80;
    server_name _;

    location / {
        client_max_body_size 80M;
        proxy_pass http://jenkin;
        proxy_cache name;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOT
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins
systemctl restart nginx.service