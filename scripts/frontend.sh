#!/bin/bash

set -ex

source .env

apt update
apt upgrade -y 

apt install apache2 -y

cp ../conf/000-default.conf /etc/apache2/sites-available

apt install php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php-zip php-gd php-intl php-soap -y

# Habiltamos el modelo rewite de apache
a2enmod rewrite

# Reiniciar apache
systemctl restart apache2

chown -R www-data:www-data /var/www/html

sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.3/apache2/php.ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.3/cli/php.ini

rm -rf /tmp/v4.5.1.zip
rm -rf /tmp/moodle-4.5.1
rm -rf /var/www/html/*

wget https://github.com/moodle/moodle/archive/refs/tags/v4.5.1.zip -P /tmp

apt install unzip -y

unzip /tmp/v4.5.1.zip -d /tmp

mv /tmp/moodle-4.5.1/* /var/www/html

mkdir -p /var/www/moodledata/

sudo chmod 777 /var/www/moodledata

chown -R www-data:www-data /var/www/moodledata

chown -R www-data:www-data /var/www/html/*


sudo -u www-data php /var/www/html/admin/cli/install.php \
    --lang="$lang" \
    --wwwroot="$wwwroot" \
    --dataroot="$dataroot" \
    --dbtype="$dbtype" \
    --dbhost="$dbhost" \
    --dbname="$dbname" \
    --dbuser="$dbuser" \
    --dbpass="$dbpass" \
    --fullname="$fullname" \
    --shortname="$shortname" \
    --summary="$summary" \
    --adminuser="$adminuser" \
    --adminpass="$adminpass" \
    --adminemail="$adminemail" \
    --non-interactive \
    --agree-license

# # Realizamos la instalacion de snap y actualizarlo
# snap install core
# snap refresh core

# # Eliminas si existe la intalacion previa de cerbot con apt
# apt remove certbot -y

# # Instalamod el clinete de Crebot con snap
# snap install --classic certbot

# # Creamos un enlace simbolico de cerbot
# ln -fs /snap/bin/certbot /usr/bin/certbot

# # Solicitamos un certificado SSL en Let´s Encript
# certbot --apache -m $LE_EMAIL --agree-tos --no-eff-email -d $LE_DOMAIN --non-interactive