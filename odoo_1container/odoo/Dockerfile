FROM debian:12

ENV TERM xterm
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LABEL distribucion="Debian 12"
LABEL descripcion="Imagen Odoo para prácticas"
LABEL maintainer=javierfp@iessanclemente.net

#Copiamos el archivo .env al container
COPY deploy.env /tmp/deploy.env

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh
#Damos permiso al entrypoint
RUN chmod +x /usr/bin/entrypoint.sh

#Copiamos el script de odoo
COPY odoo.sh /etc/init.d/odoo.sh
#Activamos el script
RUN chmod +x /etc/init.d/odoo.sh

#Creamos el usuario de odoo
RUN useradd -m -d /opt/odoo -U -s /bin/bash odoo
RUN chown odoo:odoo /opt/odoo

#Copiamos el archivo de configuración de odoo
COPY odoo.conf /opt/odoo/odoo.conf
#Damos permiso de lectura al archivo de configuración
RUN chmod +r /opt/odoo/odoo.conf

#Instalamos paquetes
RUN /bin/bash -c 'source /tmp/deploy.env; apt update; apt install -y $PACKS'

#Ejecutamos lista de comandos del envfile particular
RUN /bin/bash -c 'source /tmp/deploy.env;IFS=',';for command in $COMMANDS;do sh -c $command;done'

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
