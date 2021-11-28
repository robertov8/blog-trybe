defmodule BlogWeb.Router do
  use BlogWeb, :router

  alias BlogWeb.{Auth.Pileline, Plugs.UUIDChecker}
  alias ProperCase.Plug.SnakeCaseParams

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
    plug SnakeCaseParams
  end

  pipeline :auth do
    plug Pileline
  end

  scope "/", BlogWeb do
    pipe_through :api

    post "/user", UserController, :create
    post "/login", UserController, :login

    get "/health", HealthController, :check
  end

  scope "/user", BlogWeb do
    pipe_through [:auth, :api]

    get "/", UserController, :index
    get "/:uuid", UserController, :show
    delete "/me", UserController, :delete
  end

  scope "/post", BlogWeb do
    pipe_through [:auth, :api]

    get "/search", PostController, :search
    resources "/", PostController, param: "uuid", except: [:edit, :new]
  end
end
