source common.sh

print_head "Copy MongoDB Repo File"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo
status_check

print_head "Install MongoDB"
dnf install mongodb-org -y
status_check

print_head "Update MongoDB Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status_check

print_head "Enable MongoDB"
systemctl enable mongod
status_check

print_head "Restart MongoDB"
systemctl restart mongod
status_check

