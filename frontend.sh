pwd

exit


yum install nginx -y
systemctl enable nginx
systemctl start nginx
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

cp files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx
