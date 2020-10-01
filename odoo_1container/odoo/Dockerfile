FROM javierfpisc/odoo:v13conpostgres

MAINTAINER javierfp <javierfp@iessanclemente.net>

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh

#Damos permiso al entrypoint
RUN set -x; \
	chmod +x /usr/bin/entrypoint.sh

#Eliminamos el archivo odoo.conf de la imagen
#RUN set -x; \
#	rm /opt/odoo/odoo.conf

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
