defmodule MoodleWeb.ClockController do
  use MoodleWeb, :controller

  alias Moodle.Apicontext
  alias Moodle.Apicontext.Clock
  alias Moodle.Apicontext.Workingtime
  action_fallback MoodleWeb.FallbackController

  def index(conn, _params) do
    clock = Apicontext.list_clock()
    render(conn, "index.json", clock: clock)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Apicontext.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Apicontext.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Apicontext.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Apicontext.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def getuserclock(conn,  %{"userid" => userid}) do
    clock = Apicontext.get_user_clock!(userid)
    render(conn, "show.json", clock: clock)
  end

  def postuserclock(conn,  %{"clock" => clock_params, "userid" => userid}) do
    clock = Apicontext.get_user_clock!(userid)
    IO.puts "clock_params"
    IO.puts Map.get(clock_params, "status")
    if clock do
      if Map.get(clock_params, "status") == "true" do
        # workingtime = Apicontext.create_workingtime(%{"start" =>  Map.get(clock_params, "time"), "user" => Map.get(clock_params, "user"), "end" => DateTime.now("Etc/UTC")})
        with ({:ok, %Clock{} = clock} <- Apicontext.update_clock(clock, clock_params)) do
          render(conn, "show.json", clock: clock)
        end
        else
          IO.puts clock.status
          if clock.status do
            IO.puts "working time creation"
            workingtime = Apicontext.create_workingtime(%{"start" => clock.time, "user" => Map.get(clock_params, "user"), "end" =>  NaiveDateTime.local_now()})
            IO.puts "created"
            end
          with ({:ok, %Clock{} = clock} <- Apicontext.update_clock(clock, clock_params)) do
          render(conn, "show.json", clock: clock)
          end
      end
    else
      with {:ok, %Clock{} = newclock} <- Apicontext.create_clock(clock_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, newclock))
        |> render("show.json", clock: newclock)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Apicontext.get_clock!(id)

    with {:ok, %Clock{}} <- Apicontext.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
