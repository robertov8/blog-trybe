defmodule BlogWeb.FallbackController do
  use BlogWeb, :controller

  alias Blog.Error
  alias BlogWeb.ErrorView
  alias Ecto.Changeset

  def call(
        conn,
        {:error, %Changeset{errors: [email: {_, [{:constraint, :unique}, _]}]} = changeset}
      ) do
    conn
    |> put_status(:conflict)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset, show_field: false)
  end

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset)
  end

  def call(conn, {:error, %Error{status: status} = error}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: error)
  end

  def call(conn, error) do
    conn
    |> put_status(500)
    |> put_view(ErrorView)
    |> render("error.json", result: error)
  end
end
