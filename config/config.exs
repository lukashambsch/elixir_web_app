# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_web_app,
  ecto_repos: [ElixirWebApp.Repo]

# Configures the endpoint
config :elixir_web_app, ElixirWebAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g1HFMmxyi30U0C5Rb2DYUZq2B4Wrt4UhXGU0V80Jl8JkP9eli4oYl28MphP8JkSs",
  render_errors: [view: ElixirWebAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirWebApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure Guardian for authentication
config :elixir_web_app, ElixirWebAppWeb.Guardian,
  issuer: "ElixirWebAppWeb.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"
