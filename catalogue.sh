dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y
cp mongo.repo /etc/yum.repos.d/mongo.repo
cp catalogue.service /etc/systemd/system/catalogue.service
useradd roboshop
rm -f /app
mkdir /app
cd /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
unzip /tmp/catalogue.zip

cd /app
npm install

systemctl daemon-reload

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.thinknewtech.online </app/db/master-data.js

