defmodule Moodle.Apicontext.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :name, :string
    field :manager, :id

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :manager])
    |> validate_required([:name, :manager])
  end
end
