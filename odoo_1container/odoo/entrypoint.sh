#!/bin/bash

#Sustituimos las variables de entorno en el odoo.conf
sed -i "s/db_host = DBHOST/db_host = $DBHOST/" /opt/odoo/odoo.conf
sed -i "s/db_user = DBUSER/db_user = $DBUSER/" /opt/odoo/odoo.conf
sed -i "s/db_password = DBPASS/db_password = $DBPASS/" /opt/odoo/odoo.conf
sed -i "s/admin_passwd = ADMINPASS/admin_passwd = $ADMINPASS/" /opt/odoo/odoo.conf
sed -i "s%logfile = LOGFILE%logfile = $LOGFILE%" /opt/odoo/odoo.conf
sed -i "s/OCBDIR/$OCBDIR/" /opt/odoo/odoo.conf
#Sustituimos las variables de entorno en el odoo.sh
sed -i "s/OCBDIR/$OCBDIR/" /etc/init.d/odoo.sh

#Habilitar acceso desde host remotos a postgres
[[ $(grep "^host all all 0.0.0.0/0 md5" /etc/postgresql/15/main/pg_hba.conf) ]] || echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/15/main/pg_hba.conf
[[ $(grep "^listen_addresses='*'" /etc/postgresql/15/main/postgresql.conf) ]] || echo "listen_addresses='*'" >> /etc/postgresql/15/main/postgresql.conf

#Creamos el archivo de log y cambiamos propietario
mkdir -p $(dirname $LOGFILE)
touch $LOGFILE
chown odoo:odoo $LOGFILE

#Cambiamos propietario del filestore
[ $(stat -c "%G" $LOCALFS) == "odoo" ] || chown -R odoo:odoo $LOCALFS

#Arrancamos servicios
service postgresql start

#Crea el usuario odoo en postgres
su - postgres -c "createuser --createdb $DBUSER" && su - postgres -c "psql -c \"alter role $DBUSER with password '$DBPASS'\""

#Escribe en /etc/hosts para que resuelva postgres al localhost
echo "127.0.0.1 postgres" >> /etc/hosts

#Arranca odoo (while: la primera vez no arranca bien)
while [[ ! $(service odoo.sh start) ]];do continue;done

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 1000;done"

