FROM debian:bullseye

ENV TERM xterm
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LABEL distribucion="Debian 11"
LABEL descripcion="Imagen Postgres para prácticas SXE"

#Copiamos el deploy.env al container
COPY deploy.env /tmp/deploy.env

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh
#Damos permiso al entrypoint
RUN chmod +x /usr/bin/entrypoint.sh

#Instalamos paquetes
RUN /bin/bash -c 'source /tmp/deploy.env; apt update; apt install -y $PACKS'

#Ejecutamos lista de comandos del deploy.env
RUN /bin/bash -c 'source /tmp/deploy.env;IFS=',';for command in $COMMANDS;do sh -c $command;done'

#Limpiando
RUN apt clean

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
