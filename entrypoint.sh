#!/bin/sh


while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

echo "\n Install hex package manager..."
mix local.hex --force
mix local.rebar --force

echo "\n Install deps..."
mix deps.get 

# echo "\n DB Create..."
# mix ecto.create

echo "\n Migrations..."
mix ecto.migrate
mix run priv/repo/seeds.exs

echo "\n Launching Phoenix web server..."
# Start the phoenix web server
mix phx.server
