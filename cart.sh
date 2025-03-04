source ./common.sh
app_name=cart

cp $app_name.service /etc/systemd/system/$app_name.service
NODEJS
rm -rf /app
mkdir /app

useradd roboshop

curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
 cd /app
 unzip /tmp/$app_name.zip

 cd /app
 npm install

 systemctl daemon-reload

 systemctl enable $app_name
 systemctl start $app_name