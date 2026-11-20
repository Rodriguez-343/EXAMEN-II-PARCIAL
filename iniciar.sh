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
        tabla = cur.fetchone()[0]
        if tabla is None:
            raise SystemExit(1)
finally:
    conn.close()
PY
}

echo "Verificando base de datos Odoo..."

if ! verificar_base; then
    echo "Inicializando base de datos..."

    for intento in 1 2 3 4; do
        echo "Intento de inicializacion: $intento"

        if odoo -d "$DB_NAME" -i base \
            --without-demo \
            --stop-after-init \
            --max-cron-threads=0; then
            echo "Inicializacion completada."
            break
        fi

        if [ "$intento" -eq 4 ]; then
            echo "ERROR: No se pudo inicializar Odoo."
            exit 1
        fi

        echo "Reintentando despues de liberar bloqueos..."
        sleep 10
    done
fi

echo "Iniciando servidor Odoo..."

exec odoo -d "$DB_NAME" \
    --http-interface=0.0.0.0 \
    --http-port="$WEB_PORT" \
    --workers=0 \
    --max-cron-threads=0
