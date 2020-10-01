#!/bin/bash

#Arrancamos ssh
service ssh start

#Arranca nginx (while: la primera vez no arranca bien)
while [[ ! $(service nginx start) ]];do continue;done

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

