cp mongo.repo /etc/yum.repos.d/mongo.repo
status_print $?
dnf install mongodb-org -y
status_print $?
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status_print $?
systemctl enable mongod
status_print $?

systemctl start mongod
