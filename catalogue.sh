source common.sh

print_head "Configuring NodeJS repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>{LOG}
status_check

print_head "Install NodeJS"
yum install nodejs -y &>>{LOG}
status_check

print_head "Add Application User"
useradd roboshop &>>{LOG}
status_check

mkdir -p /app &>>{LOG}


print_head "Downloading App Content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>{LOG}
status_check

print_head "Cleanup old Content"
rm -rf /app/* &>>{LOG}
status_check

print_head "Extracting App Content"
cd /app
unzip /tmp/catalogue.zip &>>{LOG}
status_check

print_head "Installing NodeJS Dependencies"
cd /app &>>{LOG}
npm install &>>{LOG}
status_check

print_head "Configuring Catalogue Services"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>{LOG}
status_check

print_head "Reload SystemD"
systemctl daemon-reload &>>{LOG}
status_check

print_head "Enable Catalogue Services"
systemctl enable catalogue &>>{LOG}
status_check

print_head "Start Catalogue Services"
systemctl start catalogue &>>{LOG}
status_check

print_head "Configuring Mongo Repo"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>{LOG}
status_check

print_head "Install Mongo Client"
yum install mongodb-org-shell -y &>>{LOG}
status_check

print_head "Load Schema"
mongo --host mongodb-dev.lokeshviswa44.online </app/schema/catalogue.js &>>{LOG}
status_check

