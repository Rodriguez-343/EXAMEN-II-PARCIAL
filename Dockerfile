FROM odoo:20.0

USER root

COPY tienda_unicah /mnt/extra-addons/tienda_unicah
COPY unicah_prestamos /mnt/extra-addons/unicah_prestamos
COPY iniciar.sh /usr/local/bin/iniciar.sh

RUN chown -R odoo:odoo /mnt/extra-addons \
    && chmod +x /usr/local/bin/iniciar.sh

USER odoo

EXPOSE 10000

CMD ["bash", "/usr/local/bin/iniciar.sh"]

