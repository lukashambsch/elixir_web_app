defmodule ElixirWebAppWeb.PageController do
  use ElixirWebAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
