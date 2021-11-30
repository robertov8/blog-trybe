defmodule Blog.MixProject do
  use Mix.Project

  def project do
    [
      app: :blog,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Blog.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.13"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:proper_case, "~> 1.0.2"},
      {:credo, "~> 1.5.6", runtime: false},
      {:pbkdf2_elixir, "~> 1.4"},
      {:guardian, "~> 2.0.0"},
      {:ex_machina, "~> 2.7.0"},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp docs do
    [
      # Docs
      main: "Blog",
      name: "Blog",
      logo: "assets/logo.png",
      source_url: "https://github.com/robertov8/blog-trybe",
      extras: ["README.md", "docs/USAGE.md"],
      groups_for_modules: groups_for_modules()
    ]
  end

  defp groups_for_modules do
    [
      Users: [
        Blog.Users,
        Blog.Users.User
      ],
      Posts: [
        Blog.Posts,
        Blog.Posts.Post
      ],
      Plugs: [
        BlogWeb.Plugs.UUIDChecker
      ],
      "BlogWeb Auth": [
        BlogWeb.Auth.ErrorHandler,
        BlogWeb.Auth.Guardian,
        BlogWeb.Auth.Pileline,
        BlogWeb.Auth.Guardian.Plug
      ],
      "BlogWeb Controller": [
        BlogWeb.HealthController,
        BlogWeb.UserController,
        BlogWeb.PostController,
        BlogWeb.FallbackController
      ],
      "BlogWeb View": [
        BlogWeb.UserView,
        BlogWeb.PostView
      ],
      Error: [
        Blog.Error,
        BlogWeb.ErrorHelpers,
        BlogWeb.ErrorView
      ]
    ]
  end
end
