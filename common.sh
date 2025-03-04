

NODEJS(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
  useradd roboshop
  rm -rf /app
  mkdir /app
  cd /app
  curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
  unzip /tmp/$app_name.zip

  cd /app
  npm install
  cp $app_name.service /etc/systemd/system/$app_name.service
  systemctl daemon-reload
  systemctl enable $app_name
  systemctl start $app_name
}