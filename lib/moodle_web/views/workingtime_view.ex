defmodule MoodleWeb.WorkingtimeView do
  use MoodleWeb, :view
  alias MoodleWeb.WorkingtimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

   def render("showparams.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{
      id: workingtime.id,
      end: workingtime.end,
      start: workingtime.start,
      user: workingtime.user
    }
  end
end
