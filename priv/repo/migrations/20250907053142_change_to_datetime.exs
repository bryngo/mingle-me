defmodule MingleMe.Repo.Migrations.ChangeToDatetime do
  use Ecto.Migration

  def change do
    alter table(:seasons) do
      remove :start_date
      remove :end_date

      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
    end
  end
end
