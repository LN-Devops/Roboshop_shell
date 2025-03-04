dir_path=$(pwd)

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
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service
  systemctl daemon-reload
  systemctl enable $app_name
  systemctl start $app_name
}

JAVA(){
  dnf install maven -y
  cp $app_name.service /etc/systemd/system/$app_name.service
  useradd roboshop

  rm -rf /app
  mkdir /app

  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
  cd /app
  unzip /tmp/$app_name.zip

  cd /app
  mvn clean package
  mv target/$app_name-1.0.jar $app_name.jar
  systemctl daemon-reload
  systemctl enable $app_name
  systemctl start $app_name
}

python(){
  dnf install python3 gcc python3-devel -y
  cp $app_name.service /etc/systemd/system/$app_name.service
  useradd roboshop
  rm -rf /app
  mkdir /app
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
  cd /app
  unzip /tmp/$app_name.zip
  cd /app
  pip3 install -r requirements.txt
  systemctl daemon-reload
  systemctl enable $app_name
  systemctl start $app_name
}