FROM elixir:latest as build


# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config

RUN mix deps.get

# prepare release image
FROM alpine:3.14.2 AS app
# added  postgresql-client for entrypoint.sh
RUN apk add --no-cache  postgresql-client

RUN mkdir /app
WORKDIR /app

COPY entrypoint.sh .

RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

ENTRYPOINT [ "./entrypoint.sh" ] 