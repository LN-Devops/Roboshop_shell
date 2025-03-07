cp robbitmq.repo /etc/yum.repos.d/rabbitmq.repo

dnf install rabbitmq-server -y
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

rabbitmqctl add_user roboshop roboshop123
status_print $?
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
status_print $?