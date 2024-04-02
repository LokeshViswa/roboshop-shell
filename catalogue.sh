script_location=$(pwd)

print_head "Disable default NodeJS"
dnf module disable nodejs -y

print_head "Enable NodeJS:18"
dnf module enable nodejs:18 -y

print_head "Install NodeJS"
dnf install nodejs -y

print_head "Add User"
useradd roboshop

mkdir /app

print_head "Download Catalogue Content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

print_head "Unzip the content"
unzip /tmp/catalogue.zip


cd /app

print_head "Install NodeJS Dependencies"
npm install

print_head "Configuring catalogue service file"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

print_head "Reload SystemD"
systemctl daemon-reload

print_head "Enable Service"
systemctl enable catalogue

print_head "Start Catalogue service"
systemctl start catalogue

print_head "Config Mongo Repo"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install Mongo Client"
dnf install mongodb-org-shell -y

print_head "Load Schema"
mongo --host mongodb-dev.lokesh33.online </app/schema/catalogue.js


