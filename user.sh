dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y

useradd roboshop


mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

cd /app
npm install

cp ${script_location}/files/user.service /etc/systemd/system/user.service

systemctl daemon-reload

systemctl enable user
systemctl start user

