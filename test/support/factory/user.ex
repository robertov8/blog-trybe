defmodule Blog.Factory.User do
  use ExMachina.Ecto, repo: Blog.Repo

  def user_params_factory do
    %{
      display_name: "Rei do Camarote",
      email: "rei123@camarote.com",
      password: "camarote123",
      image: "https://storage.googleapis.com/image.png"
    }
  end

  def user_body_factory do
    %{
      displayName: "Rei do Camarote",
      email: "Rei123@camarote.com",
      password: "camarote123",
      image:
        "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
    }
  end

  def login_body_factory do
    %{
      email: "rei123@camarote.com",
      password: "camarote123"
    }
  end
end
