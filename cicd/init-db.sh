#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER gitlab WITH PASSWORD 'GitlabPassword123!';
    CREATE DATABASE gitlabhq_production;
    GRANT ALL PRIVILEGES ON DATABASE gitlabhq_production TO gitlab;

    CREATE USER jenkins WITH PASSWORD 'JenkinsPassword123!';
    CREATE DATABASE jenkins;
    GRANT ALL PRIVILEGES ON DATABASE jenkins TO jenkins;

    CREATE USER harbor WITH PASSWORD 'HarborPassword123!';
    CREATE DATABASE registry;
    GRANT ALL PRIVILEGES ON DATABASE registry TO harbor;
EOSQL