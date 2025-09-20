defmodule MingleMe.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MingleMe.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> MingleMe.Users.create_user()

    user
  end
end
