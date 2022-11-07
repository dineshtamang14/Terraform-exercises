#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jre -y
sudo apt install ca-certificates -y
sudo apt install maven git wget unzip -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
systemctl start jenkins 
systemctl enable jenkins

# nginx installation for reverse proxy
apt-get install nginx -y
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default
cat <<EOT> /etc/nginx/sites-available/jenkins
upstream jenkins {
  server localhost:8080;
}

server{
    listen 80;
    listen [::]:80;
    server_name _;

    location / {
      proxy_pass http://jenkins;
    }
}
EOT
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins
systemctl restart nginx.service