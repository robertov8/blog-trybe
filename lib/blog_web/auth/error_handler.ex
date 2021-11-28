defmodule BlogWeb.Auth.ErrorHandler do
  import Plug.Conn

  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(%Conn{} = conn, {_error, :token_expired}, _opts) do
    body = Jason.encode!(%{message: "Token expirado ou inválido"})

    render(conn, %{status: :unauthorized, body: body})
  end

  def auth_error(%Conn{} = conn, {_error, %ArgumentError{}}, _opts) do
    body = Jason.encode!(%{message: "Token expirado ou inválido"})

    render(conn, %{status: :unauthorized, body: body})
  end

  def auth_error(%Conn{} = conn, {_error, _reason}, _opts) do
    body = Jason.encode!(%{message: "Token não encontrado"})

    render(conn, %{status: :unauthorized, body: body})
  end

  defp render(%Conn{} = conn, %{status: status, body: body}) do
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(status, body)
  end
end
