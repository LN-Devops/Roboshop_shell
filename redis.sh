dnf module disable redis -y
status_print $?
dnf module enable redis:7 -y
status_print $?
dnf install redis -y
status_print $?
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
status_print $?

systemctl enable redis
systemctl start redis