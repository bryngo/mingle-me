defmodule MingleMe.SeasonsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MingleMe.Seasons` context.
  """

  @doc """
  Generate a season.
  """
  def season_fixture(attrs \\ %{}) do
    {:ok, season} =
      attrs
      |> Enum.into(%{
        end_time: ~U[2025-09-06 05:37:00Z],
        max_participants: 42,
        name: "some name",
        start_time: ~U[2025-09-06 05:37:00Z]
      })
      |> MingleMe.Seasons.create_season()

    season
  end
end
