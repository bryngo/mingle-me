defmodule MingleMe.Repo.Migrations.GenderToString do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :gender, :string
    end
  end
end
