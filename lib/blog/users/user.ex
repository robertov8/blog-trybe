defmodule Blog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params ~w(email password)a
  @optional_params ~w(display_name image)a

  schema "users" do
    field(:display_name, :string)
    field(:email, :string, default: "")
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:image, :string)

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params, message: "is required")
    |> validate_length(:display_name,
      min: 8,
      message: "length must be at last 8 characters long"
    )
    |> validate_email_format()
    |> validate_length(:password, min: 6, message: "length must be 6 characters long")
    |> unique_constraint(:email, message: "Usuário já existe")
    |> put_password_hash()
  end

  def changeset_login(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_not_nil(attrs, :email, "is not allowed to be empty")
    |> validate_not_nil(attrs, :password, "is not allowed to be empty")
    |> validate_required(@required_params, message: "is required")
    |> validate_email_format()
    |> apply_action(:login)
  end

  defp validate_email_format(changeset) do
    regex = ~r/[\w-\.]+@([\w-]+\.)+[\w-]{2,4}/

    validate_format(changeset, :email, regex, message: "must be a valid email")
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

  defp validate_not_nil(changeset, attrs, field, message) do
    with nil <- get_change(changeset, field),
         "" <- Map.get(attrs, Atom.to_string(field)) do
      add_error(changeset, field, message)
    else
      _ -> changeset
    end
  end
end
