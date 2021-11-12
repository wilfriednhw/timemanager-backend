FROM elixir:1.11.4-alpine as build

# install build dependencies
RUN apk add --no-cache build-base npm git python3

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
RUN mix do deps.get, deps.compile


# compile and build release
COPY lib lib


# prepare release image
FROM alpine:3.14.2 AS app
# added bash and postgresql-client for entrypoint.sh
RUN apk add --no-cache openssl ncurses-libs bash postgresql-client

RUN mkdir /app
WORKDIR /app

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/moodle ./
COPY entrypoint.sh .

RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

CMD ["bash", "/app/entrypoint.sh"]
