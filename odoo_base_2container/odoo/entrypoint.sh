#!/bin/bash

#Sustituimos las variables de entorno en el odoo.conf
sed -i "s/db_host = DBHOST/db_host = $DBHOST/" $ODOOHOME/odoo.conf
sed -i "s/db_user = DBUSER/db_user = $DBUSER/" $ODOOHOME/odoo.conf
sed -i "s/db_password = DBPASS/db_password = $DBPASS/" $ODOOHOME/odoo.conf
sed -i "s/admin_passwd = ADMINPASS/admin_passwd = $ADMINPASS/" $ODOOHOME/odoo.conf
sed -i "s%logfile = LOGFILE%logfile = $LOGFILE%" $ODOOHOME/odoo.conf
#Sustituimos las variables de entorno en el odoo.sh
sed -i "s/ODOOHOME/$ODOOHOME/" /etc/init.d/odoo.sh
sed -i "s/OCBDIR/$OCBDIR/" /etc/init.d/odoo.sh
sed -i "s/ODOOUSER/$ODOOUSER/" /etc/init.d/odoo.sh

#Creamos el archivo de log y cambiamos propietario
touch $LOGFILE
chown $ODOOUSER $LOGFILE

#Arranca odoo (while: la primera vez no arranca bien)
while [[ ! $(service odoo.sh start) ]];do continue;done

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

