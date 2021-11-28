defmodule Blog.TestHelpers do
  alias Blog.{Posts, Users}

  alias Plug.Conn
  alias Blog.Factory.{Post, User}
  alias BlogWeb.Auth.Guardian
  alias Post, as: PostFactory
  alias User, as: UserFactory

  def user_fixture(_context \\ %{}) do
    params = UserFactory.build(:user_params)
    {:ok, user} = Users.create_user(params)

    [user: user]
  end

  def post_fixture, do: post_fixture(%{})

  def post_fixture(%{user: user}) do
    params = PostFactory.build(:post_params)
    {:ok, post} = Posts.create_post(user, params)

    [post: post]
  end

  def post_fixture(_context) do
    params = UserFactory.build(:user_params)
    {:ok, user} = Users.create_user(params)

    params = PostFactory.build(:post_params)
    {:ok, post} = Posts.create_post(user, params)

    [user: user, post: post]
  end

  def authenticate(%{conn: conn, user: user}), do: do_authenticate(conn, user)

  def authenticate(%{conn: conn}) do
    [user: user] = user_fixture()

    do_authenticate(conn, user)
  end

  defp do_authenticate(conn, user) do
    {:ok, token, _} = Guardian.encode_and_sign(user)

    render_authenticate(conn, token) ++ [user: user]
  end

  def authentication_expired(%{conn: conn, user: user}),
    do: do_authentication_expired(conn, user)

  def authentication_expired(%{conn: conn}) do
    [user: user] = user_fixture()

    do_authentication_expired(conn, user)
  end

  defp do_authentication_expired(conn, user) do
    token_expired =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9" <>
        ".eyJhdWQiOiJibG9nIiwiZXhwIjoxNjM4MTMzMDg2LCJp" <>
        "YXQiOjE2MzgxMzMwMjYsImlzcyI6ImJsb2ciLCJqdGkiO" <>
        "iI1ZGIzNDdkNy04ZmNjLTQwZjEtOWE1My03NmE2ZmY2ZG" <>
        "FjNjgiLCJuYmYiOjE2MzgxMzMwMjUsInN1YiI6ImEzNzM" <>
        "0ZWEwLWIyZjMtNGIzYy1iNjg1LTYzYWI2ZjNiNjNiZCIs" <>
        "InR5cCI6ImFjY2VzcyJ9.hA4J4WVpg4xnhvd5LgoPIkq6" <>
        "rF8nCYaBaerjGejt95giDW3wVm3EvOC4TcFyJBu1FtM_i" <>
        "sYpq-hg-YzxkALJLg"

    render_authenticate(conn, token_expired) ++ [user: user]
  end

  defp render_authenticate(conn, token) do
    conn_auth =
      conn
      |> Conn.put_req_header("content-type", "application/json; charset=utf-8")
      |> Conn.put_req_header("authorization", "Bearer #{token}")

    [conn_auth: conn_auth]
  end
end
