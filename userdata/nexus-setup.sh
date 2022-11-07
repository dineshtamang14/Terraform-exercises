#!/bin/bash
yum install java-1.8.0-openjdk.x86_64 wget -y   
mkdir -p /opt/nexus/   
mkdir -p /tmp/nexus/                           
cd /tmp/nexus
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUSURL -O nexus.tar.gz
EXTOUT=`tar xzvf nexus.tar.gz`
NEXUSDIR=`echo $EXTOUT | cut -d '/' -f1`
rm -rf /tmp/nexus/nexus.tar.gz
rsync -avzh /tmp/nexus/ /opt/nexus/
useradd nexus
chown -R nexus.nexus /opt/nexus 
cat <<EOT>> /etc/systemd/system/nexus.service
[Unit]                                                                          
Description=nexus service                                                       
After=network.target                                                            
                                                                  
[Service]                                                                       
Type=forking                                                                    
LimitNOFILE=65536                                                               
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start                                  
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop                                    
User=nexus                                                                      
Restart=on-abort                                                                
                                                                  
[Install]                                                                       
WantedBy=multi-user.target                                                      

EOT

echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc
systemctl daemon-reload
systemctl start nexus
systemctl enable nexus

# nginx installation for reverse proxy
amazon-linux-extras install nginx1 -y
rm -rf /etc/nginx/conf.d/default.conf
cat <<EOT> /etc/nginx/conf.d/default.conf
proxy_cache_path  /tmp/nginx_cache levels=1:2 keys_zone=my-cache:10m max_size=1000m inactive=600m;
proxy_temp_path /tmp/cache/tmp; 


upstream nexus {
  server localhost:8081;
}

server{
    listen 80;
    listen [::]:80;
    server_name _;

    location / {
      proxy_pass http://nexus;
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
systemctl start nginx.service
systemctl enable nginx.service