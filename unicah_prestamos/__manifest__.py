{
    "name": "Préstamos de Equipos UNICAH",
    "version": "1.0",
    "summary": "Control de préstamos de equipos universitarios",
    "description": "Gestión de préstamos de equipos para estudiantes y docentes de UNICAH.",
    "category": "Services",
    "author": "Edwin Rodríguez",
    "depends": ["base", "contacts"],
    "data": [
    "security/ir.access.csv",
    "views/prestamo_views.xml",
    "views/res_partner_views.xml",
],
    "installable": True,
    "application": True,
    "license": "LGPL-3",
}