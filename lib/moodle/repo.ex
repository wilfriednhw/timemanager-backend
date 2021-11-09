defmodule Moodle.Repo do
  use Ecto.Repo,
    otp_app: :moodle,
    adapter: Ecto.Adapters.Postgres
end
