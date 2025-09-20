defmodule MingleMe.Repo.Migrations.CreateSeasons do
  use Ecto.Migration

  def change do
    create table(:seasons) do
      add :name, :string
      add :start_date, :time
      add :end_date, :time
      add :max_participants, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
