script_location=$(pwd)

print_head "Install Nginx"
dnf install nginx -y &>>${LOG}

print_head "Remove Nginx old content"
rm -rf /usr/share/nginx/html/* &>>${LOG}

print_head "Download roboshop Frontend content "
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}

cd /usr/share/nginx/html &>>${LOG}

print_head "Extract Frontend Content"
unzip /tmp/frontend.zip &>>${LOG}

print_head "Copy Roboshop Nginx config file"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}

print_head "Enable Nginx"
systemctl enable nginx &>>${LOG}

print_head "Restart Nginx"
systemctl restart nginx &>>${LOG}