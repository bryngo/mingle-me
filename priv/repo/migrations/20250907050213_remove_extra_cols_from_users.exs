defmodule MingleMe.Repo.Migrations.RemoveExtraColsFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :last_modified
      remove :created_on
    end
  end
end
