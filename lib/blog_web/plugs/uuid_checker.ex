defmodule BlogWeb.Plugs.UUIDChecker do
  import Plug.Conn

  alias Ecto.UUID
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{params: %{"uuid" => uuid}} = conn, _opts) do
    case UUID.cast(uuid) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(%Conn{} = conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{messsage: "UUID inválido"})

    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
