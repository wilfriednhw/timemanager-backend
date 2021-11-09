defmodule MoodleWeb.UserController do
  use MoodleWeb, :controller

  alias Moodle.Apicontext
  alias Moodle.Apicontext.User

  action_fallback MoodleWeb.FallbackController

  def index(conn, _params) do
    users = Apicontext.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Apicontext.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Apicontext.get_user!(id)
    render(conn, "show.json", user: user)
  end

  
  def showparams(conn, %{"email" => email, "username" => username}) do
    users = Apicontext.get_user_params!(username, email)
    render(conn, "showparams.json", users: users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Apicontext.get_user!(id)

    with {:ok, %User{} = user} <- Apicontext.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Apicontext.get_user!(id)

    with {:ok, %User{}} <- Apicontext.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
