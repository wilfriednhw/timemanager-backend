defmodule Moodle.ApicontextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Moodle.Apicontext` context.
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
      |> Moodle.Apicontext.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-10-25 12:17:00]
      })
      |> Moodle.Apicontext.create_clock()

    clock
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-25 12:29:00],
        start: ~N[2021-10-25 12:29:00]
      })
      |> Moodle.Apicontext.create_workingtime()

    workingtime
  end

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Moodle.Apicontext.create_group()

    group
  end
end
