#!/bin/sh


while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# bin="./_build/prod/rel/moodle/bin/moodle"

# migrate the database
echo "starting Migrations"
mix ecto.migrate
mix run priv/repo/seeds.exs
# eval "$bin eval \"Moodle.Release.migrate\""


# start the elixir application
echo "starting Application"
mix phx.server
# exec "$bin" "start"
