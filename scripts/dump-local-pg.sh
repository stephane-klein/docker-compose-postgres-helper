#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker compose exec postgres sh -c "pg_dump -U \$POSTGRES_USER  --no-owner --no-privileges -f /dump.sql \$POSTGRES_DB"

docker cp $(docker-compose ps -q postgres):/dump.sql dumps/dump.sql

docker compose exec postgres sh -c "rm -rf /dump.sql"

echo "Dump exported in dumps/dump.sql"
