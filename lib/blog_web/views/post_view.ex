defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  alias Blog.{Posts.Post, Users.User}

  def render("index.json", %{posts: posts}) do
    render_many(posts, PostView, "post_all.json")
  end

  def render("show.json", %{post: %Post{} = post}) do
    render_one(post, PostView, "post.json")
  end

  def render("show_with_user_id.json", %{post: %Post{} = post}) do
    render_one(post, PostView, "post_with_user_id.json")
  end

  def render("show_all.json", %{post: %Post{} = post}) do
    render_one(post, PostView, "post_all.json")
  end

  def render("post_with_user_id.json", %{post: %Post{user: %User{} = user} = post}) do
    %{id: post.id, title: post.title, userId: user.id}
  end

  def render("post.json", %{post: %Post{} = post}) do
    %{id: post.id, title: post.title}
  end

  def render("post_all.json", %{post: %Post{user: %User{} = user} = post}) do
    %{
      id: post.id,
      published: post.published,
      updated: post.updated_at,
      title: post.title,
      content: post.content,
      user: %{
        id: user.id,
        displayName: user.display_name,
        email: user.email,
        image: user.image
      }
    }
  end
end
