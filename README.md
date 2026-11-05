# Despliegue Odoo

## Objetivo

Con este repositorio se dispondrá de varios escenarios para desplegar Odoo en uno o varios docker container

## Escenarios

El escenario es el conjunto de elementos necesarios para la realización de la práctica. Consistirá en un conjunto de contenedores docker, uno o más, con funciones bien establecidas y descritas en la práctica. Tendrás que realizar los pasos indicados en la práctica en ellos, es decir serán la base de trabajo.

## Directorio de fuentes

El directorio de fuentes se Odoo estará disponible en el docker host (anfitrión) en la ruta:

~/odoo/src

Por ejemplo, podemos clonar el repositorio de OCA v19 en el directorio OCB

`mkdir -p ~/odoo/src`

`cd ~/odoo/src`

`git clone -b 19.0 --depth 1 https://github.com/OCA/OCB OCB`

Una vez descargado el repositorio en el directorio correspondiente éste se montará en el container a través del mapeo definido en el archivo **docker-compose.yml** del escenario.

## Lanzando

Para lanzar un escenario, ejecutamos desde el directorio correspondiente:

`docker-compose up -d`


