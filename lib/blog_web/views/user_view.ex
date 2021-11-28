defmodule BlogWeb.UserView do
  use BlogWeb, :view

  alias Blog.Users.User
  alias BlogWeb.UserView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: %User{} = user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: %User{} = user}) do
    %{
      id: user.id,
      displayName: user.display_name,
      email: user.email,
      image: user.image
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end
end
