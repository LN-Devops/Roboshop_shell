dnf install mysql-server -y
systemctl enable mysqld
status_print $?
systemctl start mysqld
status_print $?

mysql_secure_installation --set-root-pass RoboShop@1
status_print $?