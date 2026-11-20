FROM odoo:20.0

USER root

COPY tienda_unicah /mnt/extra-addons/tienda_unicah
COPY unicah_prestamos /mnt/extra-addons/unicah_prestamos

RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

EXPOSE 8069
