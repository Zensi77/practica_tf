#!/bin/bash

set -ex #-e rompe la ejecucion al haber un error y la x paso a paso

source .env

apt update
apt upgrade -y # La respuesta yes

apt install mysql-server -y

sed -i "s/127.0.0.1/$IP_PRIVADA_BACKEND/" /etc/mysql/mysql.conf.d/mysqld.cnf

systemctl restart mysql

mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
mysql -u root <<< "DROP USER IF EXISTS '$DB_USER'@'$IP_PRIVADA_FRONTEND';"
mysql -u root <<< "CREATE USER '$DB_USER'@'$IP_PRIVADA_FRONTEND' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$IP_PRIVADA_FRONTEND';"