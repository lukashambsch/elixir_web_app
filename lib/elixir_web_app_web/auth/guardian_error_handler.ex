defmodule ElixirWebAppWeb.GuardianErrorHandler do
  import ElixirWebAppWeb.Router.Helpers
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    if type == :unauthenticated do
      conn
        |> Phoenix.Controller.put_flash(:error, "You must be signed in to access that page.")
        |> Phoenix.Controller.redirect(to: session_path(conn, :new))
    else
      body = Poison.encode!(%{message: to_string(type) <> reason})
      send_resp(conn, 401, body)
    end
  end
end
