FROM debian:12

LABEL maintainer=javierfp@iessanclemente.net

ENV TERM xterm
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LABEL distribucion="Debian 12"
LABEL descripcion="Imagen Nginx Proxy Odoo"

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh
#Damos permiso al entrypoint
RUN chmod +x /usr/bin/entrypoint.sh

#Instalamos paquetes de utilidades
RUN apt update && apt install -y vim git curl iputils-ping net-tools nano wget procps && apt clean

#Instalamos nginx
RUN apt install -y nginx && apt clean

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
