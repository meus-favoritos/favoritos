defmodule App.SessionController do
  use App.Web, :controller

  import Guardian, only: [encode_and_sign: 2]
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias App.User

  plug :preload_current_user
    when action in [:show]
  plug :ensure_authenticated
    when action in [:show]

  def show(conn, _params) do
    user = Guardian.Plug.current_resource conn
    render conn, App.UserView, "show.json", user: user
  end

  def create(conn, %{"name" => name, "password" => password}) do
    user = Repo.get_by User, name: name
    check_user(conn, user, password)
  end
  def create(conn, %{"email" => email, "password" => password}) do
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
        |> send_resp(:unauthorized, "Wrong password")

      true ->
        dummy_checkpw()

        conn
        |> send_resp(:unauthorized, "User doesn't exist")
    end
  end
end
