#!/bin/bash

yum update -y
amazon-linux-extras install -y
yum install httpd wget unzip -y
systemctl start httpd
systemctl enable httpd
cd /tmp/
wget https://www.tooplate.com/zip-templates/2131_wedding_lite.zip
unzip -o 2131_wedding_lite.zip
cp -r 2131_wedding_lite/* /var/www/html/
systemctl restart httpd