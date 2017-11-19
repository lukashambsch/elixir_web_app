defmodule ElixirWebAppWeb.Router do
  use ElixirWebAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :with_session do
    plug ElixirWebAppWeb.Guardian.AuthPipeline.Session
    plug ElixirWebAppWeb.CurrentUser
  end

  pipeline :login_required do
    plug ElixirWebAppWeb.Guardian.AuthPipeline.Login
  end

  pipeline :admin_required do
  end

  scope "/", ElixirWebAppWeb do
    pipe_through [:browser, :with_session] # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    scope "/" do
      pipe_through [:login_required]

      resources "/users", UserController, only: [:show]

      scope "/admin", Admin, as: :admin do
        pipe_through [:admin_required]

        resources "/users", UserController, only: [:index, :show]
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirWebAppWeb do
  #   pipe_through :api
  # end
end
