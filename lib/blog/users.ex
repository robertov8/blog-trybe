defmodule Blog.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.{Error, Users.User}
  alias Ecto.UUID

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by_uuid("c263dd22-9025-4414-89e3-0801ac98a6b9")
      {:ok, %User{}}

      iex> get_user_by_uuid("123")
      {:error, reason}

  """
  def get_user_by_uuid(uuid) do
    with {:ok, uuid} <- UUID.cast(uuid),
         {:ok, %User{} = user} <- get_user_by(%{id: uuid}) do
      {:ok, user}
    else
      :error -> Error.build(:bad_request, "UUID inválido")
      error -> error
    end
  end

  def get_user_by(params) do
    case Repo.get_by(User, params) do
      nil -> {:error, Error.build(:not_found, "Usuário não existe")}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def payload_login(attrs \\ %{}) do
    User.changeset_login(%User{}, attrs)
  end
end
