defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Blog.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params ~w(title content)a
  @optional_params ~w(image user_id)a

  schema "posts" do
    field(:title, :string)
    field(:content, :string)
    field(:image, :string)
    field(:published, :utc_datetime)

    belongs_to(:user, User)

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_not_nil(attrs, :title, "is required")
    |> validate_not_nil(attrs, :content, "is required")
    |> validate_required(@required_params, message: "is required")
    |> publish_at()
  end

  defp publish_at(%Changeset{valid?: true, data: %{inserted_at: nil}} = changeset) do
    published = DateTime.truncate(DateTime.utc_now(), :second)

    change(changeset, %{published: published})
  end

  defp publish_at(changeset), do: changeset

  defp validate_not_nil(changeset, attrs, field, message) do
    case Map.get(attrs, Atom.to_string(field)) do
      "" -> add_error(changeset, field, message)
      _ -> changeset
    end
  end
end
