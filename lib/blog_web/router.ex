defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ProperCase.Plug.SnakeCaseParams
  end

  pipeline :auth do
    plug BlogWeb.Auth.Pileline
  end

  scope "/", BlogWeb do
    pipe_through :api

    post "/user", UserController, :create
    post "/login", UserController, :login

    get "/health", HealthController, :check
  end

  scope "/", BlogWeb do
    pipe_through [:api, :auth]

    get "/user", UserController, :index
    get "/user/:uuid", UserController, :show
    delete "/user/me", UserController, :delete
  end
end
