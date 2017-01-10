#!/bin/bash
if [ "$APACHE_USER" = "**False**" ]; then
    APACHE_USER="www-data"
else
	if [ "$APACHE_UID" = "**False**" ]; then
		adduser --force-badname --disabled-login $APACHE_USER
	else
		adduser --force-badname --disabled-login --uid $APACHE_UID $APACHE_USER
	fi
fi
sed -i "s/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=$APACHE_USER/" /etc/apache2/envvars
sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=$APACHE_USER/" /etc/apache2/envvars
chown $APACHE_USER:$APACHE_USER /www -R

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
