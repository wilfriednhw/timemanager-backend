ARG MIX_ENV="prod"

FROM elixir:latest as build


# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/$MIX_ENV.exs config/
RUN mix deps.compile

COPY priv priv

# note: if your project uses a tool like https://purgecss.com/,
# which customizes asset compilation based on what it finds in
# your Elixir templates, you will need to move the asset compilation
# step down so that `lib` is available.
COPY assets assets
RUN mix assets.deploy

# compile and build the release
COPY lib lib
RUN mix compile
# changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM alpine:3.12.1 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs

RUN mkdir /app
WORKDIR /app

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/moodle ./

RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

ENTRYPOINT ["bin/moodle"]

# Usage:
#  * build: sudo docker image build -t elixir/moodle .
#  * shell: sudo docker container run --rm -it --entrypoint "" -p 127.0.0.1:4000:4000 elixir/moodle sh
#  * run:   sudo docker container run --rm -it -p 127.0.0.1:4000:4000 --name moodle elixir/moodle
#  * exec:  sudo docker container exec -it moodle sh
#  * logs:  sudo docker container logs --follow --tail 100 moodle
CMD ["start"]