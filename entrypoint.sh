#!/bin/sh


while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done


echo "Install hex package manager"
mix local.hex --force
mix local.rebar --force

echo "Install deps"
mix deps.get --force

# migrate the database
echo "starting Migrations"
mix ecto.migrate
mix run priv/repo/seeds.exs


# start the elixir application
echo "starting Application"
mix phx.server
