defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BlogWeb do
    pipe_through :api
  end

  scope "/health", BlogWeb do
    get("/", HealthController, :check)
  end
end
