{
    "name": "Tienda UNICAH",
    "version": "1.0",
    "summary": "Convenios de descuento para la tienda universitaria",
    "category": "Sales/Sales",
    "author": "Edwin Rodriguez",
    "depends": ["sale_management"],
    "data": [
        "security/ir.model.access.csv",
        "views/res_partner_views.xml",
        "views/sale_order_views.xml",
        "views/tienda_convenio_views.xml"
    ],
    "installable": True,
    "application": True,
    "license": "LGPL-3"
}
