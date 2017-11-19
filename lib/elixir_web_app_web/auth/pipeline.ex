defmodule ElixirWebAppWeb.Guardian.AuthPipeline.Session do
  use Guardian.Plug.Pipeline, otp_app: :elixir_web_app,
                              module: ElixirWebAppWeb.Guardian,
                              error_handler: ElixirWebAppWeb.GuardianErrorHandler
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
end

defmodule ElixirWebAppWeb.Guardian.AuthPipeline.Login do
  use Guardian.Plug.Pipeline, otp_app: :elixir_web_app,
                              module: ElixirWebAppWeb.Guardian,
                              error_handler: ElixirWebAppWeb.GuardianErrorHandler

  plug Guardian.Plug.EnsureAuthenticated
end
