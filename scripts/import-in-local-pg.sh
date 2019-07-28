#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

./scripts/clean-db.sh
docker cp dumps/dump.sql $(docker-compose ps -q postgres):/dump.sql
docker-compose exec postgres sh -c "cd /sqls/ && psql --quiet -U \$POSTGRES_USER \$POSTGRES_DB -f /dump.sql && rm -f /dump.sql"