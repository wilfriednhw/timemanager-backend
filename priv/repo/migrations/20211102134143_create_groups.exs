defmodule Moodle.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :manager, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:groups, [:manager])
  end
end
