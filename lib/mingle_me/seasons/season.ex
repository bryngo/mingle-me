defmodule MingleMe.Seasons.Season do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seasons" do
    field :name, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :max_participants, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(season, attrs) do
    season
    |> cast(attrs, [:name, :start_time, :end_time, :max_participants])
    |> validate_required([:name, :start_time, :end_time, :max_participants])
  end
end
