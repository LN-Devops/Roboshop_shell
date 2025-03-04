source ./common.sh
app_name=catalogue


cp mongo.repo /etc/yum.repos.d/mongo.repo
cp $app_name.service /etc/systemd/system/$app_name.service

NODEJS


systemctl daemon-reload

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.thinknewtech.online </app/db/master-data.js

