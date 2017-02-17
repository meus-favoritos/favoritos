defmodule App.ErrorHandler do
  use App.Web, :controller
  require Logger

  alias App.ErrorView

  def handle_errors(conn, %{reason: {:error, :not_found}}) do
    conn
    |> not_found
  end

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{}}) do
    conn
    # explicit render since pipelines don't run in this case therefore there's
    # no way to set a default format
    |> put_status(404)
    |> render(ErrorView, "404.html", %{})
  end

  def handle_errors(conn, %{reason: %Ecto.NoResultsError{}}) do
    conn
    |> not_found
  end

  def handle_errors(conn, reason) do
    if Mix.env == :dev do
      Logger.error (inspect reason)
    end

    conn
    |> send_resp(conn.status, "Something went wrong")
  end

  # Called by Guardian
  def unauthenticated(conn, %{reason: {:error, :no_session}}) do
    conn
    |> unauthenticated
  end

  # Helpers

  def unauthenticated(conn) do
    conn
    |> put_status(401)
    |> render(ErrorView, :"401", %{})
  end

  def not_found(conn) do
    conn
    |> put_status(404)
    |> render(ErrorView, :"404", %{})
  end
end
