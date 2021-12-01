defmodule BlogWeb.Auth.ErrorHandler do
  import Plug.Conn

  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  @spec auth_error(Conn.t(), {any, any}, any) :: Conn.t()
  def auth_error(%Conn{} = conn, {_error, :token_expired}, _opts) do
    render(conn, "Token expirado ou inválido")
  end

  def auth_error(%Conn{} = conn, {_error, %ArgumentError{}}, _opts) do
    render(conn, "Token expirado ou inválido")
  end

  def auth_error(%Conn{} = conn, {_error, _reason}, _opts) do
    render(conn, "Token não encontrado")
  end

  defp render(conn, message) do
    body = Jason.encode!(%{message: message})

    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:unauthorized, body)
  end
end
