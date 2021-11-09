defmodule MoodleWeb.ClockView do
  use MoodleWeb, :view
  alias MoodleWeb.ClockView

  def render("index.json", %{clock: clock}) do
    %{data: render_many(clock, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status
    }
  end
end
