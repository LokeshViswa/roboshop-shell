source common.sh

if [ -z "${roboshop_rabbitmq_password}" ]; then
  echo "Variable roboshop_rabbitmq_password is missing"
  exit 1
fi

print_head "Configure Yum Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
status_check

print_head "Configure Yum Repos for RabbitMQ"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
status_check

print_head "Install RabbitMQ"
dnf install rabbitmq-server -y
status_check

print_head "Enable RabbitMQ"
systemctl enable rabbitmq-server
status_check

print_head "Start RabbitMQ"
systemctl start rabbitmq-server
status_check

print_head "Add application User"
rabbitmqctl list_users | grep roboshop
if [ $? -ne 0 ]; then
  rabbitmqctl add_user roboshop ${roboshop_rabbitmq_password}
fi
status_check

print_head "Add Permissions to Application User"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
status_check
