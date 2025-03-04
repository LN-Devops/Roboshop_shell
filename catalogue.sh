source ./common.sh
app_name=catalogue

NODEJS
cp mongo.repo /etc/yum.repos.d/mongo.repo
cp $app_name.service /etc/systemd/system/$app_name.service
useradd roboshop
rm -f /app
mkdir /app
cd /app
curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
unzip /tmp/$app_name.zip

cd /app
npm install

systemctl daemon-reload

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.thinknewtech.online </app/db/master-data.js

