dnf install nginx -y

systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/* 