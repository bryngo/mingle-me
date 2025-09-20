defmodule MingleMe.Repo.Migrations.AddGender do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :gender, :integer
    end
  end
end
