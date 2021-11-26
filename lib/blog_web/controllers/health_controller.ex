defmodule BlogWeb.HealthController do
  @moduledoc """
  Health check controller
  """

  use BlogWeb, :controller

  def check(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("ok")
  end
end
