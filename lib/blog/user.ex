defmodule Blog.User do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params ~w(email password_hash)a
  @optional_params ~w(display_name image)a

  schema "users" do
    field(:display_name, :string)
    field(:email, :string)
    field(:password_hash, :string)
    field(:image, :string)

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end
end
