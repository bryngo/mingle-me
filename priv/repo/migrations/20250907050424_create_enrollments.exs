defmodule MingleMe.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :user_id, :integer
      add :season_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
