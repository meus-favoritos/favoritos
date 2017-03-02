defmodule App.Web.ErrorHandler do
  use App.Web, :controller
  require Logger

  alias App.Web.ErrorView

  # Called by Guardian
  def unauthenticated(conn, _reason) do
    conn
    |> put_status(401)
    |> render(ErrorView, :"401", %{})
  end

  def handle_errors(conn, %{reason: %Bodyguard.NotAuthorizedError{status: 403}}) do
    conn
    |> put_status(403)
    |> render(ErrorView, :"403", %{})
  end

  def handle_errors(conn, %{reason: %{plug_status: status}})
  when status in [404, 406] do
    conn
    # explicit render since pipelines don't run in this cases therefore there's
    # no way to set a default format
    |> put_status(status)
    |> render(ErrorView, "#{status}.json", %{})
  end

  def handle_errors(conn, %{reason: reason}) do
    status = Plug.Exception.status(reason)

    status_atom =
      status
      |> Integer.to_string
      |> String.to_atom

    conn
    |> put_status(status)
    |> render(ErrorView, status_atom, %{})
  end
end
