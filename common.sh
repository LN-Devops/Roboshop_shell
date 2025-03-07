dir_path=$(pwd)
log_file=/tmp/roboshop.log
rm -rf $log_file


SYSTEMD_SETUP(){
  echo Creating service for the application
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
  status_print $?

  echo re-loading the service
  systemctl daemon-reload &>>$log_file
  status_print $?

  echo enabling the service
  systemctl enable $app_name &>>$log_file
  status_print $?

  echo starting the service
  systemctl start $app_name &>>$log_file
  status_print $?

}
APP_PREREQ(){
  echo adding user to the application
  useradd roboshop &>>$log_file
  status_print $?

  echo removing the directory
  rm -rf /app &>>$log_file
  status_print $?

  echo creating the directory
  mkdir /app &>>$log_file
  status_print $?

  cd /app &>>$log_file
  status_print $?

  echo downloading the artifactory for application
  curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  status_print $?

  echo extracting the artifacts
  unzip /tmp/$app_name.zip &>>$log_file
  cd /app &>>$log_file
  status_print $?

}
status_print(){
  if [ $1 -eq 0 ]; then
      echo -e " \e[32mSUCCESS\e[0m"
    else
      echo -e " \e[31mFAILURE\e[0m"
      exit 1
    fi
}
NODEJS(){
  echo disabling the nodejs version
  dnf module disable nodejs -y &>>$log_file
  status_print $?

  echo enabling the nodejs version
  dnf module enable nodejs:20 -y &>>$log_file
  status_print $?

  echo installing the nodejs version
  dnf install nodejs -y &>>$log_file
  status_print $?

  APP_PREREQ
  echo downloading the required dependancies
  npm install &>>$log_file
  status_print $?

  SYSTEMD_SETUP

}

JAVA(){
  echo downloading maven for java application
  dnf install maven -y  &>>$log_file
  

  APP_PREREQ
  echo downloading the dependancies
  mvn clean package &>>$log_file
  mv target/$app_name-1.0.jar $app_name.jar &>>$log_file
  status_print $?
  SYSTEMD_SETUP
}

python(){
  dnf install python3 gcc python3-devel -y &>>$log_file
  status_print $?
  APP_PREREQ
  pip3 install -r requirements.txt &>>$log_file
  status_print $?
  SYSTEMD_SETUP
}