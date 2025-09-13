FROM debian:12

LABEL maintainer=javierfp@iessanclemente.net

ENV TERM xterm
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LABEL distribucion="Debian 12"
LABEL descripcion="Imagen Auditoría Odoo"

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh
#Damos permiso al entrypoint
RUN chmod +x /usr/bin/entrypoint.sh

#Instalamos paquetes de utilidades de auditoría
RUN apt update && apt install -y vim git curl iputils-ping nano wget procps nmap \
gobuster hydra dirb sslscan net-tools jq perl python3-odoorpc && apt clean

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
