
from odoo import api, fields, models
from odoo.exceptions import ValidationError


class UnicahPrestamo(models.Model):
    _name = "unicah.prestamo"
    _description = "Préstamo de equipo universitario"
    _order = "fecha_prestamo desc, id desc"

    name = fields.Char(
        string="Código de préstamo",
        required=True,
    )

    estudiante_id = fields.Many2one(
        "res.partner",
        string="Solicitante",
        required=True,
    )

    equipo = fields.Char(
        string="Equipo",
        required=True,
    )

    cantidad = fields.Integer(
        string="Cantidad",
        default=1,
        required=True,
    )

    fecha_prestamo = fields.Date(
        string="Fecha de préstamo",
        required=True,
        default=fields.Date.context_today,
    )

    fecha_devolucion = fields.Date(
        string="Fecha de devolución",
        required=True,
    )

    dias_prestamo = fields.Integer(
        string="Días de préstamo",
        compute="_compute_dias_prestamo",
        store=True,
    )

    estado = fields.Selection(
        [
            ("borrador", "Borrador"),
            ("prestado", "Prestado"),
            ("devuelto", "Devuelto"),
        ],
        string="Estado",
        default="borrador",
        required=True,
    )

    observaciones = fields.Text(
        string="Observaciones",
    )

    @api.depends("fecha_prestamo", "fecha_devolucion")
    def _compute_dias_prestamo(self):
        for prestamo in self:
            if prestamo.fecha_prestamo and prestamo.fecha_devolucion:
                prestamo.dias_prestamo = (
                    prestamo.fecha_devolucion
                    - prestamo.fecha_prestamo
                ).days
            else:
                prestamo.dias_prestamo = 0

    @api.constrains("cantidad")
    def _check_cantidad(self):
        for prestamo in self:
            if prestamo.cantidad <= 0:
                raise ValidationError(
                    "La cantidad de equipos debe ser mayor que cero."
                )

    @api.constrains("fecha_prestamo", "fecha_devolucion")
    def _check_fechas(self):
        for prestamo in self:
            if (
                prestamo.fecha_prestamo
                and prestamo.fecha_devolucion
                and prestamo.fecha_devolucion < prestamo.fecha_prestamo
            ):
                raise ValidationError(
                    "La fecha de devolución no puede ser anterior "
                    "a la fecha de préstamo."
                )
