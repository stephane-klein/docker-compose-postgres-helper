# docker-compose postgres helper scripts

Features:

- [x] Start and wait Postgres
- [x] Load seed schema
- [x] Load fixtures
- [x] Enter in PostgreSQL interactive terminal
- [x] Dump local database
- [x] Import in local database

## How to use

```sh
$ docker compose version
Docker Compose version 2.2.2
```

Start Postgres and wait it starting:

```
$ docker compose up -d postgres --wait
```

Initialize database with seed schema:

```
$ ./scripts/seed.sh
"Database cleaning..."
"Database cleaned"
"Schema creating..."
"Schema created"
```

Load fixtures:

```
$ ./scripts/fixtures.sh
"Cleaning tables..."
"Tables cleaned"
"Loading users fixtures..."
"Users fixtures loaded"
```

Enter in Postgres PostgreSQL interactive terminal:

```
$ ./scripts/enter-in-pg.sh
psql (11.4)
Type "help" for help.

postgres=# \d
         List of relations
 Schema | Name  | Type  |  Owner
--------+-------+-------+----------
 public | users | table | postgres
(1 row)

postgres=# select * from users limit 2;
                  id                  |  username   |          email           |                        password_hash                         |          created_at          |          updated_at
--------------------------------------+-------------+--------------------------+--------------------------------------------------------------+------------------------------+------------------------------
 1de9c987-08ab-32fe-e218-89c124cd0001 | username001 | username 001@example.com | $2a$11$27s.UnSqrdSGwYSmacQzcOzjgZJFsmAQRY6OhcHTEWA4pmRFxYEWy | 2019-07-28 09:54:38.73218+00 | 2019-07-28 09:54:38.73218+00
 1de9c987-08ab-32fe-e218-89c124cd0002 | username002 | username 002@example.com | $2a$11$27s.UnSqrdSGwYSmacQzcOzjgZJFsmAQRY6OhcHTEWA4pmRFxYEWy | 2019-07-28 09:54:38.73218+00 | 2019-07-28 09:54:38.73218+00
(2 rows)
```

Generate local dump:

```
$ ./scripts/dump-local-pg.sh
Dump exported in dumps/dump.sql
```

Import dump locally:

```
$ ./scripts/import-in-local-pg.sh
```

Display table size:

```
$ ./scripts/display-table-sizes.sh | grep "users"
 public.users                                             | 48 kB      | 32 kB        | 80 kB
```

How to execute multiline SQL command:

```
$ cat << EOF | docker compose exec -T postgres sh -c "psql --quiet -U \$POSTGRES_USER \$POSTGRES_DB"
CREATE OR REPLACE FUNCTION drop_all ()
   RETURNS VOID  AS
   \$\$
   DECLARE rec RECORD;
   BEGIN
       -- Get all the schemas
        FOR rec IN
        SELECT nspname FROM pg_catalog.pg_namespace WHERE (nspname NOT LIKE 'pg_%') and (nspname != 'information_schema')
           LOOP
             EXECUTE 'DROP SCHEMA ' || rec.nspname || ' CASCADE';
           END LOOP;
           RETURN;
   END;
   \$\$ LANGUAGE plpgsql;

SELECT drop_all();
EOF
```
