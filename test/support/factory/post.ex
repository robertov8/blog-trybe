defmodule Blog.Factory.Post do
  use ExMachina.Ecto, repo: Blog.Repo

  def post_params_factory do
    %{
      title: "Agregando valor a esse post",
      content: "Tudo isso aí é inveja"
    }
  end
end
