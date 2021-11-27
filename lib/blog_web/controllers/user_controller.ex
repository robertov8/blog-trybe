defmodule BlogWeb.UserController do
  use BlogWeb, :controller

  alias Blog.{Users, Users.User}
  alias BlogWeb.Auth.Guardian

  action_fallback BlogWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("sign_in.json", token: token)
    end
  end

  def show(conn, %{"uuid" => uuid}) do
    with {:ok, %User{} = user} <- Users.get_user_by_uuid(uuid) do
      render(conn, "show.json", user: user)
    end
  end

  def login(conn, params) do
    with {:ok, %User{}} <- Users.payload_login(params),
         {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def delete(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
