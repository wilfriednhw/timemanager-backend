#!/bin/sh


while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

bin="/app/bin/moodle"

# migrate the database
echo "starting Migrations"
eval "$bin eval \"HelloHeroku.Release.migrate\""

# start the elixir application
echo "starting Application"
exec "$bin" "start"
