script_location=$(pwd)

cp $script_location=$(pwd)/files/mongodb.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y

systemctl enable mongod
systemctl start mongod

systemctl restart mongod
