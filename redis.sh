source common.sh

print_head "Install Redis Repo"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
status_check

print_head "Enable Redis"
dnf module enable redis:remi-6.2 -y &>>${LOG}
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

