defmodule MingleMe.Repo.Migrations.AddUserInterests do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :interests, {:array, :string}, default: []
    end
  end
end
