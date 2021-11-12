FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# Install deps
RUN mix deps.get 

# Compile the project
# RUN mix do compile -- force
# RUN chmod +x ./entrypoint.sh

# ENTRYPOINT [ "./entrypoint.sh" ] 