defmodule App.Web.SessionView do
  use App.Web, :view

  def render("token.json", %{token: token}) do
    %{data: %{token: token}}
  end
end
