#!/bin/bash

#Sustituimos las variables de entorno en el odoo.conf
sed -i "s/db_host = DBHOST/db_host = $DBHOST/" $ODOOHOME/odoo.conf
sed -i "s/db_user = DBUSER/db_user = $DBUSER/" $ODOOHOME/odoo.conf
sed -i "s/db_password = DBPASS/db_password = $DBPASS/" $ODOOHOME/odoo.conf
sed -i "s/admin_passwd = ADMINPASS/admin_passwd = $ADMINPASS/" $ODOOHOME/odoo.conf
sed -i "s%logfile = LOGFILE%logfile = $LOGFILE%" $ODOOHOME/odoo.conf
sed -i "s%ODOOHOME%$ODOOHOME%g" $ODOOHOME/odoo.conf
sed -i "s/OCBDIR/$OCBDIR/" $ODOOHOME/odoo.conf
#Sustituimos las variables de entorno en el odoo.sh
sed -i "s%ODOOHOME%$ODOOHOME%g" /etc/init.d/odoo.sh
sed -i "s/OCBDIR/$OCBDIR/" /etc/init.d/odoo.sh
sed -i "s/ODOOUSER/$ODOOUSER/" /etc/init.d/odoo.sh

#Habilitar acceso desde host remotos a postgres
[[ $(grep "^host all all 0.0.0.0/0 md5" /etc/postgresql/11/main/pg_hba.conf) ]] || echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/11/main/pg_hba.conf
[[ $(grep "^listen_addresses='*'" /etc/postgresql/11/main/postgresql.conf) ]] || echo "listen_addresses='*'" >> /etc/postgresql/11/main/postgresql.conf

#Creamos el archivo de log y cambiamos propietario
mkdir -p $(dirname $LOGFILE)
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

