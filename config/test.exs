import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :moodle, Moodle.Repo,

  username: "postgres",
  password: "postgres",
  database: "moodledb",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10


# We don't run a server during test. If one is required,
# you can enable the server option below.
config :moodle, MoodleWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 80],
  secret_key_base: "Bfs5EnOQ6+1uBdt1mBCn3Yy288alO2T6VmU9ZZ174X6zRK6DHHu3exycyj5utFCk",
  server: false

# In test we don't send emails.
config :moodle, Moodle.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
