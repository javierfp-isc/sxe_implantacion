#!/bin/bash

#Arrancamos servicios
service postgresql start

#Crea el usuario odoo en postgres
su - postgres -c "createuser --createdb $DBUSER" && su - postgres -c "psql -c \"alter role $DBUSER with password '$DBPASS'\""

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

