# Examen II Parcial — Programación de Negocios

**Universidad Católica de Honduras (UNICAH)**  
**Estudiante:** Edwin René Acosta Rodríguez  
**Número de cuenta:** 0101200504493  
**Asignatura:** Programación de Negocios  
**Docente:** Ing. Ludwing Navarro  
**Sección:** 1701

## Descripción

Proyecto académico desarrollado en **Odoo 20** para administrar convenios de descuento de la tienda universitaria de UNICAH y registrar préstamos de equipos universitarios.

## Módulos incluidos

### `tienda_unicah`

- Extensión de contactos con tipo de cliente, número de cuenta y carrera.
- Gestión de convenios para estudiantes, docentes y personal administrativo.
- Aplicación de descuentos en cotizaciones y registro de la operación en el historial.
- Validación de números de cuenta, porcentajes y fechas de convenios.
- Límite de 10 unidades por pedido para estudiantes.
- Cálculo del ahorro por convenio, visualización en ventas, filtros y agrupación.

### `unicah_prestamos`

- Registro de préstamos de equipos a contactos de Odoo.
- Campos de código, solicitante, equipo, cantidad, fechas, duración, estado y observaciones.
- Cálculo automático de días de préstamo.
- Validaciones de cantidad positiva y fechas coherentes.
- Vistas de lista y formulario, menú propio y permisos de acceso.
- Integración con el formulario de Contactos para consultar los préstamos asociados.

## Requisitos

- Odoo 20 y sus dependencias.
- PostgreSQL configurado para la instancia de Odoo.
- Aplicación de Ventas de Odoo (`sale_management`) para `tienda_unicah`.

## Instalación

1. Copiar las carpetas `tienda_unicah` y `unicah_prestamos` a una ruta incluida en `addons_path` del archivo `odoo.conf`.
2. Actualizar la lista de aplicaciones o ejecutar desde la carpeta de instalación de Odoo:

   ```powershell
   python odoo-bin -c odoo.conf -d NOMBRE_BASE -i tienda_unicah,unicah_prestamos --stop-after-init
   ```

3. Iniciar el servidor de Odoo y acceder a las aplicaciones de Ventas, Contactos y Préstamos UNICAH.

Para actualizar módulos ya instalados:

```powershell
python odoo-bin -c odoo.conf -d NOMBRE_BASE -u tienda_unicah,unicah_prestamos --stop-after-init
```

## Pruebas realizadas

- Registro de cliente y validación de número de cuenta.
- Convenios con porcentajes y fechas válidos e inválidos.
- Aplicación de descuento estudiantil y cálculo del ahorro.
- Restricción de pedidos de más de 10 unidades para estudiantes.
- Creación de préstamo `PREST-001` y cálculo automático de 3 días.
- Rechazo de préstamos con cantidad 0 y fechas de devolución anteriores al préstamo.
- Visualización del préstamo desde la ficha del contacto.

## Historial de entregas

- `5a6fef6` — Parte 1: Datos universitarios del cliente.
- `abcdcb2` — Partes 2 y 3: Convenios y descuentos en ventas.
- `4d461e2` — Partes 4, 5 y 6: Validaciones, ahorro y préstamos UNICAH.

## Repositorio

https://github.com/Rodriguez-343/EXAMEN-II-PARCIAL

> Proyecto elaborado con fines académicos para el Examen II Parcial.
