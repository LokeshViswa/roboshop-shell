source common.sh

print_head "Copy MongoDB Repo File"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "Install MongoDB"
dnf install mongodb-org -y &>>${LOG}
status_check

print_head "Update MongoDB Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check

print_head "Enable MongoDB"
systemctl enable mongod &>>${LOG}
status_check

print_head "Restart MongoDB"
systemctl restart mongod &>>${LOG}
status_check

