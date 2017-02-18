defmodule App.ErrorView do
  use App.Web, :view

  # 400

  def render("400.json", assigns) do
    api_error(assigns, 404, "bad request")
  end

  def render("400.html", _assigns) do
    "Bad Request"
  end

  # 401

  def render("401.json", assigns) do
    api_error(assigns, 401, "unauthenticated")
  end

  def render("401.html", _assigns) do
    "Unauthorized"
  end

  # 404

  def render("404.json", assigns) do
    api_error(assigns, 404, "not found")
  end

  def render("404.html", _assigns) do
    "Not Found"
  end

  # 406

  def render("406.json", assigns) do
    api_error(assigns, 406, "not acceptable")
  end

  def render("406.html", _assigns) do
    "not acceptable"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    "internal server error"
  end

  # Helpers

  defp api_error(assigns, status, default_message) do
    message = Map.get(assigns, :message, default_message)

    %{
      code: status,
      message: message
    }
  end
end
