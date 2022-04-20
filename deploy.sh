#!/bin/bash

if [ -f /etc/systemd/system/news-app.service ]; then
  sudo systemctl restart news-app
else
    echo "Creating Service file"
    cat >/etc/systemd/system/news-app.service <<EOL
[Unit]
Description=News Java service

[Service]
WorkingDirectory=/root/news-service
ExecStart=/bin/java -Xms128m -Xmx256m -jar news-app.jar
User=ubuntu
Type=simple
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOL
    chown -R ubuntu:ubuntu /root/news-service
    sudo systemctl daemon-reload
    sudo systemctl enable news-app
    sudo systemctl start news-app
fi