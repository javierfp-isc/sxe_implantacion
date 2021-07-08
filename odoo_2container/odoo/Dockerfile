FROM debian:buster

ENV TERM xterm
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LABEL maintainer=javierfp@iessanclemente.net
LABEL distribucion="Debian 10"
LABEL descripcion="Imagen Odoo para prácticas"

#Copiamos el envfile al container
COPY envfile /tmp/envfile

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh
#Damos permiso al entrypoint
RUN chmod +x /usr/bin/entrypoint.sh

#Copiamos el script de odoo
COPY odoo.sh /etc/init.d/odoo.sh
#Activamos el script
RUN chmod +x /etc/init.d/odoo.sh

#Creamos el usuario de odoo
RUN useradd -m -d /opt/odoo -U -s /bin/bash odoo; chown odoo:odoo /opt/odoo

#Copiamos el archivo de configuración de odoo
COPY odoo.conf /opt/odoo/odoo.conf

#Instalamos paquetes de utilidades
RUN /bin/bash -c 'source /tmp/envfile; apt update; apt install -y $PACKUTILS'

#Instalamos paquetes de base para odoo
RUN /bin/bash -c 'source /tmp/envfile; apt install -y $PACKODOO'

#wkhtmltopdf
RUN cd /tmp; wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb -O wkhtmltox_0.12.5-1.buster_amd64.deb; \
    apt install -y /tmp/wkhtmltox_0.12.5-1.buster_amd64.deb

#Descargando archivo requirements para odoo
RUN /bin/bash -c 'source /tmp/envfile; wget https://raw.githubusercontent.com/OCA/OCB/$ODOOV/requirements.txt -O /tmp/requirements.txt'

#Instalando paquetes python para odoo
RUN pip3 install -r /tmp/requirements.txt

#Limpiando
RUN apt clean

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
