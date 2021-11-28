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

  scope "/user", BlogWeb do
    pipe_through [:api, :auth]

    get "/", UserController, :index
    get "/:uuid", UserController, :show
    delete "/me", UserController, :delete
  end

  scope "/post", BlogWeb do
    pipe_through [:api, :auth]

    get "/search", PostController, :search
    resources "/", PostController, param: "uuid", except: [:edit, :new]
  end
end
