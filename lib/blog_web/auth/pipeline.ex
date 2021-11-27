defmodule BlogWeb.Auth.Pileline do
  use Guardian.Plug.Pipeline, otp_app: :blog

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
