#!/bin/bash

#Habilitar acceso desde host remotos
[[ $(grep "^host all all 0.0.0.0/0 md5" /etc/postgresql/13/main/pg_hba.conf) ]] || echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/13/main/pg_hba.conf
[[ $(grep "^listen_addresses='*'" /etc/postgresql/13/main/postgresql.conf) ]] || echo "listen_addresses='*'" >> /etc/postgresql/13/main/postgresql.conf

#Arrancamos servicios
service postgresql start

#Crea el usuario odoo en postgres
su - postgres -c "createuser --createdb $DBUSER" && su - postgres -c "psql -c \"alter role $DBUSER with password '$DBPASS'\""

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

