defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.{Posts, Posts.Post}

  action_fallback BlogWeb.FallbackController

  def action(conn, _) do
    current_user = Guardian.Plug.current_resource(conn)

    apply(__MODULE__, action_name(conn), [conn, conn.params, current_user])
  end

  def index(conn, _params, _current_user) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, post_params, current_user) do
    with {:ok, %Post{} = post} <- Posts.create_post(current_user, post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show_with_user_id.json", post: post)
    end
  end

  def show(conn, %{"uuid" => uuid}, _current_user) do
    with {:ok, %Post{} = post} <- Posts.get_post_by_uuid(uuid) do
      render(conn, "show_all.json", post: post)
    end
  end

  def update(conn, %{"uuid" => uuid} = post_params, current_user) do
    with {:ok, %Post{} = post} <- Posts.get_post_by_user(current_user, uuid),
         {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
      render(conn, "post.json", post: post)
    end
  end

  def search(conn, params, _current_user) do
    search = Map.get(params, "q", "")

    posts = Posts.list_posts_by_term(search)

    render(conn, "index.json", posts: posts)
  end

  def delete(conn, %{"uuid" => uuid}, current_user) do
    with {:ok, %Post{} = post} <- Posts.get_post_by_user(current_user, uuid),
         {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
