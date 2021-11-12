#!/bin/sh


while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done


# migrate the database
echo "starting Migrations"
exec mix ecto.migrate

# start the elixir application
echo "starting Application"
exec mix phx.server
