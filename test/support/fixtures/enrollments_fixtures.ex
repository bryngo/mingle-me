defmodule MingleMe.EnrollmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MingleMe.Enrollments` context.
  """

  @doc """
  Generate a enrollment.
  """
  def enrollment_fixture(attrs \\ %{}) do
    {:ok, enrollment} =
      attrs
      |> Enum.into(%{
        season_id: 42,
        user_id: 42
      })
      |> MingleMe.Enrollments.create_enrollment()

    enrollment
  end
end
