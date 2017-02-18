defmodule App.UserView do
  use App.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, App.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, App.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    user
    |> Map.take([:id, :name, :email])
  end
end
