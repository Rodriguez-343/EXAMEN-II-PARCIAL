#!/bin/bash
set -e

export PGHOST="$HOST"
export PGPORT="5432"
export PGUSER="$USER"
export PGPASSWORD="$PASSWORD"

export PORT="${PORT:-10000}"

echo "Verificando base de datos Odoo..."

if ! python3 - <<'PY'
import psycopg2

conn = psycopg2.connect(dbname="odoo20_clase")
try:
    with conn.cursor() as cur:
        cur.execute("SELECT to_regclass('public.ir_module_module')")
        exists = cur.fetchone()[0]
finally:
    conn.close()

if not exists:
    raise SystemExit(1)
PY
then
    echo "Inicializando tablas de Odoo..."
    odoo -d odoo20_clase -i base \
        --without-demo=all \
        --stop-after-init
fi

echo "Iniciando servidor Odoo..."

exec odoo -d odoo20_clase \
    --http-interface=0.0.0.0 \
    --http-port="$PORT" \
    --workers=0 \
    --max-cron-threads=0
