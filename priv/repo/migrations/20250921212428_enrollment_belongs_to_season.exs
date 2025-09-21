defmodule MingleMe.Repo.Migrations.EnrollmentBelongsToSeason do
  use Ecto.Migration

  def change do
    alter table(:enrollments) do
      remove :season_id
      remove :user_id
      add :season_id, references(:seasons)
      add :user_id, references(:users)
    end

    create index(:enrollments, [:season_id])
  end
end
