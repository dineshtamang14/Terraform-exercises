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
proxy_cache_path  /tmp/nginx_cache levels=1:2 keys_zone=my-cache:10m max_size=1000m inactive=600m;
proxy_temp_path /tmp/cache/tmp; 


upstream jenkins {
  server localhost:8080;
}

server{
    listen 80;
    listen [::]:80;
    server_name _;

    location / {
      proxy_pass http://jenkins;
      proxy_cache my-cache;
      proxy_set_header Host \$host;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_ignore_headers Set-Cookie; 
      proxy_ignore_headers Cache-Control; 
      proxy_cache_bypass \$http_secret_header;
      add_header X-Cache-Status \$upstream_cache_status;
    }
}
EOT
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins
systemctl restart nginx.service