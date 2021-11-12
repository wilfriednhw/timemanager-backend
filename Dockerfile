
# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app


ENTRYPOINT ["./entrypoint.sh"]

# EXPOSE 7000 # Add this line for Dev