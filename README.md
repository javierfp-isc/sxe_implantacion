# Despliegue Odoo

## Objetivo

Con este repositorio se dispondrá de varios escenarios para desplegar Odoo en uno o varios docker container

## Pasos previos a realizar

La información con los pasos previos y requisitos del entorno de prácticas se encuentran en:

[REQUISITOS](https://github.com/javierfp-isc/sxe_requisitos)

## Escenarios

El escenario es el conjunto de elementos necesarios para la realización de la práctica. Consistirá en un conjunto de contenedores docker, uno o más, con funciones bien establecidas y descritas en la práctica. Tendrás que realizar los pasos indicados en la práctica en ellos, es decir serán la base de trabajo.

Este repositorio contiene 5 escenarios:

- **odoo_despliegue**: creación sencilla de 1 container para odoo
- **odoo_1container**: despliegue completo de odoo en 1 container (odoo+postgres)
- **odoo_2container**: despliegue completo de odoo en 2 containers (odoo y postgres por separado)
- **nginx_odoo**: despliegue de dos instancias de odoo pasando por proxy nginx
- **nginx_odoo_ssl**: despliegue de dos instancias de odoo pasando por proxy nginx actuando en alta disponibilidad (HA)

## Directorio de fuentes

El directorio de fuentes se Odoo estará disponible en el docker host (anfitrión) en la ruta:

~/odoo/src

Por ejemplo, podemos clonar el repositorio de OCA v17 en el directorio OCB

`mkdir -p ~/odoo/src`

`cd ~/odoo/src`

`git clone -b 17.0 --depth 1 https://github.com/OCA/OCB OCB`

Una vez descargado el repositorio en el directorio correspondiente éste se montará en el container a través del mapeo definido en el archivo **docker-compose.yml** del escenario.

## Lanzando

Por ejemplo, para lanzar el escenario **odoo_2container**, el cual despliega odoo en dos container:

`cd odoo_2container`

`docker-compose up -d`

NOTA.- En el archivo odoo/deploy.env se definen parámetros para el despliegue, entre otros:

* **ODOOV=17.0**: Versión de Odoo a desplegar, en este caso la 177.0
* **OCBDIR=OCB**: Directorio en el directorio ~/odoo/src del host con las fuentes de Odoo, en este caso el directorio OCB


