#!/bin/bash
set -e

export PGHOST="$HOST"
export PGPORT="5432"
export PGUSER="$USER"
export PGPASSWORD="$PASSWORD"

WEB_PORT="${PORT:-10000}"
DB_NAME="odoo20_clase"

verificar_base() {
    python3 - <<'PY'
import psycopg2

conn = psycopg2.connect(dbname="odoo20_clase")
try:
    with conn.cursor() as cur:
        cur.execute("SELECT to_regclass('public.ir_module_module')")
        if cur.fetchone()[0] is None:
            raise SystemExit(1)
finally:
    conn.close()
PY
}

echo "Verificando base de datos Odoo..."

if ! verificar_base; then
    echo "Inicializando base de datos..."

    for intento in 1 2 3 4; do
        if odoo -d "$DB_NAME" -i base \
            --without-demo \
            --stop-after-init \
            --max-cron-threads=0; then
            break
        fi

        if [ "$intento" -eq 4 ]; then
            echo "ERROR: No se pudo inicializar Odoo."
            exit 1
        fi

        sleep 10
    done
fi

echo "Verificando instalacion de Tienda UNICAH..."

ESTADO=$(python3 - <<'PY'
import psycopg2

conn = psycopg2.connect(dbname="odoo20_clase")
try:
    with conn.cursor() as cur:
        cur.execute(
            "SELECT state FROM ir_module_module WHERE name = %s",
            ("tienda_unicah",)
        )
        result = cur.fetchone()
        print(result[0] if result else "not_found")
finally:
    conn.close()
PY
)

echo "Estado actual de tienda_unicah: $ESTADO"

if [ "$ESTADO" = "to install" ]; then
    echo "Completando instalacion de Tienda UNICAH..."

    odoo -d "$DB_NAME" -i tienda_unicah \
        --without-demo \
        --stop-after-init \
        --max-cron-threads=0

    echo "Instalacion de Tienda UNICAH completada."
fi

echo "Iniciando servidor Odoo..."

exec odoo -d "$DB_NAME" \
    --http-interface=0.0.0.0 \
    --http-port="$WEB_PORT" \
    --workers=0 \
    --max-cron-threads=0
