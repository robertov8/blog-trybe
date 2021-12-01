defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Users.User
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params ~w(title content)a
  @optional_params ~w(image user_id)a

  @type t :: %__MODULE__{
          id: binary() | nil,
          title: binary() | nil,
          content: binary() | nil,
          image: binary() | nil,
          user_id: binary() | nil
        }

  schema "posts" do
    field(:title, :string)
    field(:content, :string)
    field(:image, :string)
    field(:published, :utc_datetime)

    belongs_to(:user, User)

    timestamps()
  end

  @spec changeset(post :: __MODULE__.t(), attrs :: map()) :: Changeset.t()
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_not_nil(attrs, :title, "is required")
    |> validate_not_nil(attrs, :content, "is required")
    |> validate_required(@required_params, message: "is required")
    |> publish_at()
  end

  @spec changeset_update(post :: __MODULE__.t(), attrs :: map()) ::
          {:ok, Ecto.Schema.t() | map()} | {:error, Ecto.Schema.t()}
  def changeset_update(post, attrs) do
    post
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_not_nil(attrs, :title, "is required")
    |> validate_not_nil(attrs, :content, "is required")
    |> validate_required(@required_params, message: "is required")
    |> apply_action(:login)
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
