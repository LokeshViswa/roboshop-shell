source common.sh

print_head "Disable Redis"
dnf module disable redis -y
status_check

print_head "Enable Redis"
dnf module enable redis:6 -y &>>${LOG}
status_check

print_head "Install Redis"
dnf install redis -y &>>${LOG}
status_check

print_head "Update Redis listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>${LOG}
status_check

print_head "Enable Redis"
systemctl enable redis &>>${LOG}
status_check

print_head "Start Redis"
systemctl start redis &>>${LOG}
status_check

