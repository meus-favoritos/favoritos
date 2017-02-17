defmodule App.User do
  use App.Web, :model

  alias App.Helpers
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(struct, _params \\ %{}) do
    struct
    |> validate_length(:name, min: 6, max: 64)
    |> validate_length(:password, min: 6)
    |> validate_format(:name, Helpers.username_regex)
    |> validate_format(:email, Helpers.email_regex)
    |> put_password_hash
    |> unique_constraint(:name)
    |> unique_constraint(:email)
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password, :password_confirmation])
    |> changeset
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password, :password_confirmation])
    |> changeset
  end

  # Helpers

  defp put_password_hash(changeset) do
    confirmation = get_change(changeset, :password_confirmation)

    case get_change(changeset, :password) do
      password
        when is_binary(password) and password == confirmation ->
          changeset
          |> put_change(:password_hash, hashpwsalt(password))

      password
        when is_binary(password) and password != confirmation ->
          changeset
          |> add_error(:password, "does not match confirmation")

      _ ->
        changeset
    end
  end
end
