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

#Creamos el archivo de log y cambiamos propietario
mkdir -p $(dirname $LOGFILE)
touch $LOGFILE
chown -R $ODOOUSER:$ODOOUSER $(dirname $LOGFILE)

#Arranca odoo (while: la primera vez no arranca bien)
while [[ ! $(service odoo.sh start) ]];do continue;done

#Cambiamos permisos del directorio de odoo
[ $(stat -c "%G" /opt/odoo) == "odoo" ] || chown -R odoo:odoo /opt/odoo

#Cambiamos propietario del filestore
[ $(stat -c "%G" $LOCALFS) == "odoo" ] || chown -R odoo:odoo $LOCALFS

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 1000;done"

