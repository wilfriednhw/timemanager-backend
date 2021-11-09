defmodule Moodle.Apicontext.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :group, :id
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :group, :role])
    |> validate_required([:username, :email, :group, :role])
    |> validate_format(:email, ~r/@/)
  end
end
