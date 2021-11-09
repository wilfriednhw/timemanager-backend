defmodule MoodleWeb.PageController do
  use MoodleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
