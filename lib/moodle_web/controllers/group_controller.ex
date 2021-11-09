defmodule MoodleWeb.GroupController do
  use MoodleWeb, :controller

  alias Moodle.Apicontext
  alias Moodle.Apicontext.Group

  action_fallback MoodleWeb.FallbackController

  def index(conn, _params) do
    groups = Apicontext.list_groups()
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Apicontext.create_group(group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Apicontext.get_group!(id)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Apicontext.get_group!(id)

    with {:ok, %Group{} = group} <- Apicontext.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Apicontext.get_group!(id)

    with {:ok, %Group{}} <- Apicontext.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
