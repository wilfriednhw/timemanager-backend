defmodule Moodle.Repo.Migrations.AddUserGroup do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :group, references(:groups, on_delete: :nothing)
    end
  end
end
