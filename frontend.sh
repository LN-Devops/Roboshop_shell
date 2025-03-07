dnf module disable nginx -y
status_print $?

dnf module enable nginx:1.24 -y
status_print $?

dnf install nginx -y
status_print $?

cp nginx.conf /etc/nginx/nginx.conf
status_print $?
rm -rf /usr/share/nginx/html/*
status_print $?
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
status_print $?

cd /usr/share/nginx/html
status_print $?
unzip /tmp/frontend.zip
status_print $?
systemctl restart nginx
status_print $?