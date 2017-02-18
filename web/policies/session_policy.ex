defmodule App.Session.Policy do
  def can?(nil, :show, _), do: false
  def can?(_user, :show, _), do: true

  def can?(nil, :create, _), do: true
  def can?(_user, :crate, _), do: false
end
