script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[35m Install nginx\e[0m"
yum install nginx -y &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo -e "\e[35m Remove Nginx Old Content \e[0m"
rm -rf /usr/share/nginx/html/* &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo -e "\e[35m Download Fronted Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

cd /usr/share/nginx/html &>>{LOG}

echo -e "\e[35m Extract Fronted Content\e[0m"
unzip /tmp/frontend.zip &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo -e "\e[35m Copy Roboshop Nginx Config File \e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo -e "\e[35m Enable Nginx\e[0m"
systemctl enable nginx &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo -e "\e[35m Start Nginx\e[0m"
systemctl restart nginx &>>{LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi