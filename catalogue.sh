source ./common.sh
app_name=catalogue

cp mongo.repo /etc/yum.repos.d/mongo.repo
status_print $?
NODEJS


dnf install mongodb-mongosh -y
status_print $?
mongosh --host mongodb-dev.thinknewtech.online </app/db/master-data.js
status_print $?

