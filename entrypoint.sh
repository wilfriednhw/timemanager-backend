#!/bin/sh
# Docker entrypoint script.


# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
    echo "$(date) - waiting for database to start"
    sleep 2
done
# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
    echo "Database $PGDATABASE does not exist. Creating..."
    createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
    echo "Database $PGDATABASE created."
fi


# echo $PWD
# exec ls
# # Sets up tables and running migrations.

# # eval "Moodle.Release.migrate"

# # Start our app
# # exec start


