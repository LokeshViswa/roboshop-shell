source common.sh

print_head "Install Golang"
dnf install golang -y &>>${LOG}
status_check

APP_PREREQ

print_head "Install Dependencies and Build Software"
cd /app &>>${LOG}
go mod init dispatch &>>${LOG}
go get &>>${LOG}
go build &>>${LOG}
status_check

print_head "Update Passwords in Service File"
sed -i -e "s/roboshop_rabbitmq_password/${roboshop_rabbitmq_password}/" ${script_location}/files/${component}.service  &>>${LOG}
status_check

SYSTEMD_SETUP

