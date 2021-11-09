defmodule MoodleWeb.WorkingtimeController do
  use MoodleWeb, :controller

  alias Moodle.Apicontext
  alias Moodle.Apicontext.Workingtime

  action_fallback MoodleWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Apicontext.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Apicontext.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Apicontext.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def showparams(conn, %{"id" => id, "start" => start, "end" => endtime}) do
    workingtimes = Apicontext.get_workingtimes_params!(id, start, endtime)
    render(conn, "showparams.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Apicontext.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Apicontext.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Apicontext.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Apicontext.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  def workingTimeUserId(conn, %{"id" => id}) do
    workingtimes = Apicontext.get_workingtime_user!(id)

    render(conn, "index.json", workingtimes: workingtimes)
  end
end
