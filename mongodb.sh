script_location=$(pwd)

print_head "Copy MongoDB Repo File"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install MongoDB"
dnf install mongodb-org -y

print_head "Update MongoDB Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

print_head "Enable MongoDB"
systemctl enable mongod

print_head "Restart MongoDB"
systemctl restart mongod

