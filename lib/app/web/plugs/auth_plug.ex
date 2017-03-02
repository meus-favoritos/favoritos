defmodule App.Web.Plugs.AuthPlug do
  alias Guardian.Plug.{EnsureAuthenticated}
  import Guardian.Plug, only: [current_resource: 1]
  import Plug.Conn

  def preload_current_user(conn, _opts \\ %{}) do
    user = current_resource conn
    assign conn, :current_user, user
  end

  def ensure_authenticated(conn, _opts \\ %{}) do
    EnsureAuthenticated.call conn, EnsureAuthenticated.init(handler: App.Web.ErrorHandler)
  end
end
