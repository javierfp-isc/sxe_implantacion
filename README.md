# Despliegue Odoo

## Objetivo

En esta práctica se va a desplegar Odoo en uno o varios docker container

## Pasos previos a realizar

La primera vez que realicéis una práctica será necesario configurar el entorno del sistema en el que se ejecutará. Una vez hecho se usará para todas las demás. Para desplegar el sistema para las prácticas seguid las instrucciones en:

[REQUISITOS](REQUISITOS.md)

### Archivo de variables alumno.yaml

Dentro del directorio **tests/vars** hay un archivo **alumno.yaml**, el cual contiene una lista de variables que deberéis especificar para cada práctica. El tipo y número dependerá de la misma, pero como mínimo deberéis indicar vuestro **nombre** y **el token de acceso** a gitlab de vuestro usuario.

`#Variables que debe especificar el alumno`

`nombre_alumno: Javier Fernández Peón`

`gitlab_token: 9HMCTHQDCJAfeqsPjtzY`

*NOTAD que al ser formato YAML la sintaxis es del tipo clave: valor*

## Escenarios

El escenario es el conjunto de elementos necesarios para la realización de la práctica. Consistirá en un conjunto de contenedores docker, uno o más, con funciones bien establecidas y descritas en la práctica. Tendrás que realizar los pasos indicados en la práctica en ellos, es decir serán la base de trabajo.

Este repositorio contiene 3 escenarios:

- **odoo_despliegue**: creación sencilla de 1 container para odoo
- **odoo_1container**: despliegue completo de odoo en 1 container
- **odoo_2container**: despliegue completo de odoo en 2 containers
- *nginx_odoo*: despliegue de dos instancias de odoo pasando por proxy nginx

### Creación del escenario de la práctica

Antes de crear el escenario hay que realizar un cambio en el archivo **docker-compose.yml **dentro del directorio de cada escenario de la práctica. En este caso dentro de los directorios anteriores.

En la sección *volumes* sustituís:

**/home/javierfp/odoo** 

por la misma ruta pero en vuestro directorio home, el cual tendrá la forma: /home/SANCLEMENTE/<vuestro_usuario>. Por ejemplo si mi usuario es javierfp, la ruta sería:

**/home/SANCLEMENTE/javierfp**

Una vez realizado el cambio anterior, para crear el escenario de la práctica entramos en el directorio del escenario (en el que se ubica el **docker-compose.yml**) y dentro del mismo ejecutamos desde la terminal el comando:

`docker-compose up -d`

El comando anterior creará todos los container docker y los elementos necesarios para la práctica

### Detener y arrancar el escenario

Después de una sesión de trabajo con el escenario debemos de detener el mismo para poder retomarlo más adelante. Para ello ejecutamos desde el mismo directorio del apartado anterior

`docker-compose stop`

Más adelante cuando retomemos el trabajo levantamos de nuevo el escenario ejecutando desde el mismo directorio:

`docker-compose start`

### Acceder al container

Podemos acceder a un container de varios modos

#### Acceder mediante docker-compose exec

**docker-compose exec nombre_servicio bash**

donde nombre_servicio es el nombre del servicio dentro del archivo docker-compose para el container, los cuales se encuentran definidos dentro de la sección services en el archivo encabezando cada sección de creación de container. Por ejemplo si tengo en el docker-compose:

`version: '2'`

`services:`

 `#Service odoo toma el Dockerfile de ./build/odoo`
 
 `odoo:`
 
 etc.
 
 entonces podría acceder a ese container con el comando:
 
 `docker-compose exec odoo bash` 
 
#### Acceder mediante docker exec -it

También podría acceder directamente el container usando el nombre del container (no el del servicio docker-compose).
 
 Para ver los docker container en ejecución del escenario ejecutamos:

`docker ps`

Si el nombre del container es **odoo_despliegue_odoo_1** accederemos a él con:

`docker exec -it odoo_despliegue_odoo_1 bash`

#### Acceder mediante ssh

Otra opción sería usar la propia dirección IP del container y acceder por ssh, pues éste servicio está habilitado por defecto en el container. Si la dirección IP es por ejemplo **192.168.199.13**, ejecutaría:

`ssh root@192.168.199.13`

### Eliminar el escenario

Al terminar la práctica y entregar los resultados podéis eliminar el escenario, aunque es recomendable dejarlo durante un tiempo por si necesitáis repasar. Para eliminar los container del escenario y todos los elementos ejecutamos desde el mismo directorio:

`docker-compose down`

O si queremos eliminar también las imágenes docker

`docker-compose down --rmi all`

Si en el escenario se ha creado algún volumen de datos asociado al container y queremos que éstos se borren, deberíamos también añadir la opción -v, por ejemplo para borrar containers, networks, imágenes y volúmenes usaríamos:

`docker-compose down --rmi all -v`

## Realización de la práctica

Una vez creado el escenario de la práctica es el momento de tomar el enunciado y realizar las tareas que se indican en el mismo. El escenario anterior habrá creado uno o varios docker containers y todos los artefactos necesarios.

En el enunciado de la práctica se te indicará qué hacer en cada container.

## Realización de los test

Los tests son un conjunto de pruebas que se lanzarán de forma automática en el escenario y que comprobarán si has realizado correctamente los pasos y ejercicios indicados en la práctica.

### Ejecución de los tests

Para ejecutar los test nos situamos dentro del directorio test y lanzamos desde la terminal el comando:

`ansible-playbook test.yaml`

Veremos en la salida del comando los mensajes de error si alguno de los test falla.

Si todo los tests se pasan con éxito al final del comando veremos un mensaje del tipo

**"ENHORABUENA!. Has superado todos los test"**

En caso contrario, si alguno falla el mensaje será:

**"LO SIENTO!. No has superado todos los test"**

por tanto deberás de revisar cual ha fallado y realizar las correcciones oportunas

### Archivos de log

Puedes ver también el resultado de la ejecución de los test, además de en la salida de la terminal, en los archivos

**log/test.log**: Toda la salida

**log/report.log**: Salida resumida

## Entrega

Una vez que finalices correctamente la práctica, es decir con todos los test superados, para realizar la entrega de los resultados de ejecución de la misma deberás ejecutar el comando:

`ansible-playbook test.yaml -e entregar=yes`

Si hay algún error en los tests lo verás como se explica en el apartado anterior, **en cuyo caso la entrega no se realizará**

### Entrega forzada

Si quieres realizar la entrega **aún cuando algún test haya fallado** ejecuta el comando:

`ansible-playbook test.yaml -e entregar=yes -e force=yes`

## Referencias

### git

[introduccion a git](https://aulasoftwarelibre.github.io/taller-de-git/introduccion/)

### docker

[breve introduccion a docker](https://guiadev.com/introduccion-a-docker/)

### docker-compose

[docker compose de un vistazo](https://docs.docker.com/compose/)
