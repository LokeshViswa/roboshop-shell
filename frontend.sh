source common.sh

print_head "Install Nginx"
dnf install nginx -y &>>${LOG}
status_check

print_head "Remove Nginx old content"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "Download Roboshop Frontend content "
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${LOG}
status_check

cd /usr/share/nginx/html &>>${LOG}

print_head "Extract Frontend Content"
unzip /tmp/frontend.zip &>>${LOG}
status_check

print_head "Copy Roboshop Nginx config file"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "Enable Nginx"
systemctl enable nginx &>>${LOG}
status_check

print_head "Restart Nginx"
systemctl restart nginx &>>${LOG}
status_check
