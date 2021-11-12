#!/bin/sh


while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done


mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs

echo "\n Launching Phoenix web server..."
# Start the phoenix web server
mix phx.server
