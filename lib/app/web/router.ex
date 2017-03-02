defmodule App.Web.Router do
  use App.Web, :router

  @non_rest [:new, :edit]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end


  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", App.Web do
    pipe_through :api

    resources "/users", UserController, except: @non_rest
    get "/sessions", SessionController, :show
    post "/sessions", SessionController, :create
  end

  scope "/", App.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  defp handle_errors(conn, reason) do
    App.Web.ErrorHandler.handle_errors(conn, reason)
  end
end
