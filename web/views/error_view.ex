defmodule App.ErrorView do
  use App.Web, :view


  def render("400.json", _assigns) do
    %{code: 400, error: "bad request"}
  end

  def render("400.html", _assigns) do
    "Bad Request"
  end

  def render("401.json", %{message: message}) do
    %{code: 401, error: message}
  end

  def render("401.json", _assigns) do
    %{code: 401, error: "unauthenticated"}
  end

  def render("401.html", _assigns) do
    "Unauthorized"
  end

  def render("404.json", _assigns) do
    %{code: 404, error: "not found"}
  end

  def render("404.html", _assigns) do
    "Not Found"
  end

  def render("500.json", _assigns) do
    %{code: 500, error: "internal server error"}
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
