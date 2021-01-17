#!/bin/bash

#Sustituimos las variables de entorno en el odoo.conf
sed -i "s/db_host = DBHOST/db_host = $DBHOST/" $ODOOHOME/odoo.conf
sed -i "s/db_user = DBUSER/db_user = $DBUSER/" $ODOOHOME/odoo.conf
sed -i "s/db_password = DBPASS/db_password = $DBPASS/" $ODOOHOME/odoo.conf
sed -i "s/admin_passwd = ADMINPASS/admin_passwd = $ADMINPASS/" $ODOOHOME/odoo.conf
sed -i "s%logfile = LOGFILE%logfile = $LOGFILE%" $ODOOHOME/odoo.conf

#Creamos el archivo de log y cambiamos propietario
touch $LOGFILE
chown $ODOOUSER $LOGFILE

#Arrancamos servicios
service postgresql start

#Crea el usuario odoo en postgres
su - postgres -c "createuser --createdb $DBUSER" && su - postgres -c "psql -c \"alter role $DBUSER with password '$DBPASS'\""

#Escribe en /etc/hosts para que resuelva postgres al localhost
echo "127.0.0.1 postgres" >> /etc/hosts

#Arranca odoo (while: la primera vez no arranca bien)
while [[ ! $(service odoo.sh start) ]];do continue;done

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

