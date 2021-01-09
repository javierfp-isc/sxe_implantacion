#!/bin/bash

#Sale si un comando termina con un valor de retorno diferente a 0
set -e

#Arrancamos servicios
service ssh start
service postgresql start

#Crea el usuario odoo en postgres
su - postgres -c "createuser --createdb $DBUSER" && su - postgres -c "psql -c \"alter role $DBUSER with password '$DBPASS'\""

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

