source ./common.sh
app_name=shipping

JAVA

dnf install mysql -y
status_print $?
for file in schema app-user master-data; do
  mysql -h mysql-dev.thinknewtech.online -uroot -pRoboShop@1 < /app/db/$file.sql &>>$log_file
done

