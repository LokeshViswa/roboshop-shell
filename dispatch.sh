source common.sh

print_head "Install Golang"
dnf install golang -y
status_check

APP_PREREQ

print_head "Install Dependencies and Build Software"
cd /app
go mod init dispatch
go get
go build
status_check

SYSTEMD_SETUP

