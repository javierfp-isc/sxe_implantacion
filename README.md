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
- **odoo_1container**: despliegue completo de odoo en 1 container
- **odoo_2container**: despliegue completo de odoo en 2 containers
- **nginx_odoo**: despliegue de dos instancias de odoo pasando por proxy nginx
- **nginx_odoo_ssl**: despliegue de dos instancias de odoo pasando por proxy nginx actuando en alta disponibilidad (HA)
