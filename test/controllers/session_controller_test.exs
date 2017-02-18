defmodule App.SessionControllerTest do
  use App.ConnCase

  alias App.{Repo, User}

  @valid_attrs %{name: "lubien", password: "123456"}
  @invalid_attrs %{name: "foobar", password: "abcdef"}
  @empty_attrs %{}

  setup %{conn: conn} do
    changeset = User.create_changeset %User{}, %{
      name: "lubien",
      email: "lubien1996@gmail.com",
      password: "123456",
      password_confirmation: "123456",
    }

    Repo.insert! changeset

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "unauthenticated :show", %{conn: conn} do
    assert_error_sent 401, fn ->
      conn = get conn, session_path(conn, :show)
      json_response(conn, 200)
    end
  end

  test "session :create", %{conn: conn} do
    conn = post conn, session_path(conn, :create, @valid_attrs)
    assert json_response(conn, 200)["data"]["token"]
  end

  test "invalid session :create", %{conn: conn} do
    assert_error_sent 400, fn ->
      conn = post conn, session_path(conn, :create, @empty_attrs)
      json_response(conn, 200)
    end

    assert_error_sent 401, fn ->
      conn = post conn, session_path(conn, :create, @invalid_attrs)
      json_response(conn, 200)
    end
  end

  test "session :show", %{conn: conn} do
    token_conn = post conn, session_path(conn, :create, @valid_attrs)
    token = json_response(token_conn, 200)["data"]["token"]

    conn = put_req_header(conn, "authorization", token)
    conn = get conn, session_path(conn, :show)

    assert json_response(conn, 200)["data"]["id"]
  end
end
