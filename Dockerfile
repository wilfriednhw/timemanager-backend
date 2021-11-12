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
RUN mix deps.compile

# compile and build release
RUN mix compile,
RUN mix release,  

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