# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN MIX_ENV="prod"

# RUN apt-get update && \
#   apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# Install deps
RUN mix deps.get 

RUN mix ecto.migrate
RUN mix run priv/repo/seeds.exs
RUN mix phx.server

# Compile the project
# RUN mix do compile -- force
# RUN chmod +x ./entrypoint.sh
# ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]

# EXPOSE 7000