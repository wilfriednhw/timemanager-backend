defmodule Moodle.ApiContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Moodle.ApiContext` context.
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
      |> Moodle.ApiContext.create_user()

    user
  end
end
