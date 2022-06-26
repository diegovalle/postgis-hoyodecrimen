#!/bin/bash
set -e

## Add read-only user for hoyodecrimen
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
     CREATE ROLE hoyodecrimen WITH LOGIN PASSWORD '$HOYODECRIMEN_USER_PASSWORD'
     NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';

     GRANT USAGE ON SCHEMA topology to hoyodecrimen;
     GRANT SELECT ON ALL SEQUENCES IN SCHEMA topology TO hoyodecrimen;
     GRANT SELECT ON ALL TABLES IN SCHEMA topology TO hoyodecrimen;

     GRANT USAGE ON SCHEMA tiger to hoyodecrimen;
     GRANT SELECT ON ALL SEQUENCES IN SCHEMA tiger TO hoyodecrimen;
     GRANT SELECT ON ALL TABLES IN SCHEMA tiger TO hoyodecrimen;

     GRANT CONNECT ON DATABASE apihoyodecrimen TO hoyodecrimen;
     GRANT USAGE ON SCHEMA public TO hoyodecrimen;
     GRANT SELECT ON ALL TABLES IN SCHEMA public TO hoyodecrimen;
     GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO hoyodecrimen;

     ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO hoyodecrimen;

EOSQL

## Add a read-only user for making backups
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
     CREATE ROLE hoyodecrimen_backup WITH LOGIN PASSWORD '$BACKUP_USER_PASSWORD'
     NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';

     GRANT USAGE ON SCHEMA topology to hoyodecrimen_backup;
     GRANT SELECT ON ALL SEQUENCES IN SCHEMA topology TO hoyodecrimen_backup;
     GRANT SELECT ON ALL TABLES IN SCHEMA topology TO hoyodecrimen_backup;

     GRANT USAGE ON SCHEMA tiger to hoyodecrimen_backup;
     GRANT SELECT ON ALL SEQUENCES IN SCHEMA tiger TO hoyodecrimen_backup;
     GRANT SELECT ON ALL TABLES IN SCHEMA tiger TO hoyodecrimen_backup;

     GRANT CONNECT ON DATABASE apihoyodecrimen TO hoyodecrimen_backup;
     GRANT USAGE ON SCHEMA public TO hoyodecrimen_backup;
     GRANT SELECT ON ALL TABLES IN SCHEMA public TO hoyodecrimen_backup;
     GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO hoyodecrimen_backup;

     ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO hoyodecrimen_backup;

EOSQL
