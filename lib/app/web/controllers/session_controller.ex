defmodule App.Web.SessionController do
  use App.Web, :controller

  import Guardian, only: [encode_and_sign: 2]
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias App.Web.{User, ErrorView}
  alias App.Web.Session.Policy

  plug :preload_current_user
    when action in [:show]

  def show(conn, _params) do
    authorize! conn, %{}, policy: Policy

    user = Guardian.Plug.current_resource conn
    render conn, App.Web.UserView, "show.json", user: user
  end

  def create(conn, %{"name" => name, "password" => password}) do
    authorize! conn, %{}, policy: Policy

    user = Repo.get_by User, name: name
    check_user(conn, user, password)
  end
  def create(conn, %{"email" => email, "password" => password}) do
    authorize! conn, %{}, policy: Policy

    user = Repo.get_by User, email: email
    check_user(conn, user, password)
  end

  # Helpers

  def check_user(conn, user, password) do
    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, token, _full_claims} = encode_and_sign(user, :access)
        render(conn, "token.json", token: token)

      user ->
        conn
        |> put_status(401)
        |> render(ErrorView, :"401", message: "wrong credentials")

      true ->
        dummy_checkpw()

        conn
        |> put_status(401)
        |> render(ErrorView, :"401", message: "user not found")
    end
  end
end
