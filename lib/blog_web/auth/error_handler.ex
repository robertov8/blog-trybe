defmodule BlogWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(conn, {_error, :token_expired}, _opts) do
    body = Jason.encode!(%{message: "Token expirado ou inválido"})

    render(conn, %{status: :unauthorized, body: body})
  end

  def auth_error(conn, {_error, %ArgumentError{}}, _opts) do
    body = Jason.encode!(%{message: "Token expirado ou inválido"})

    render(conn, %{status: :unauthorized, body: body})
  end

  def auth_error(conn, {_error, _reason}, _opts) do
    body = Jason.encode!(%{message: "Token não encontrado"})

    render(conn, %{status: :unauthorized, body: body})
  end

  defp render(conn, %{status: status, body: body}) do
    conn
    |> Conn.put_resp_header("Content-Type", "application/json; charset=utf-8")
    |> Conn.send_resp(status, body)
  end
end
