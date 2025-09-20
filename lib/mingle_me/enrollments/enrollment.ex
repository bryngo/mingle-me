defmodule MingleMe.Enrollments.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "enrollments" do
    field :user_id, :integer
    field :season_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> cast(attrs, [:user_id, :season_id])
    |> validate_required([:user_id, :season_id])
  end
end
