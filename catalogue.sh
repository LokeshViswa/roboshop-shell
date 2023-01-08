script_location=$(pwd)
set -e


curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

#useradd roboshop
mkdir -p /app
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
rm -rf /app/*
cd /app

unzip /tmp/catalogue.zip
cd /app
npm install

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue