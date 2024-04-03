source common.sh

if [ -z "${root_mysql_password}" ]; then
  echo "Variable root_mysql_password is missing"
  exit 1
fi

print_head "Disable MySQL Default Module"
dnf module disable mysql -y

print_head "Copy MySQL Repo File"
cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo

print_head "Install MySQL Server"
dnf install mysql-community-server -y

print_head "Enable MySQL"
systemctl enable mysqld

print_head "Start MySQL"
systemctl start mysqld

print_head "Reset Default Database Password"
mysql_secure_installation --set-root-pass ${root_mysql_password}
if [ $? -eq 1 ]; then
  echo "Password is already changed"
fi

