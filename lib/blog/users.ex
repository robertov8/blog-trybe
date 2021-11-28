defmodule Blog.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.{Error, Users.User}

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
    with {:ok, %User{} = user} <- get_user_by(%{id: uuid}) do
      {:ok, user}
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
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Error{}}

  """
  def delete_user(%User{} = user) do
    case Repo.delete(user, stale_error_field: true) do
      {:ok, user} -> {:ok, user}
      {:error, _changeset} -> {:error, Error.build(:not_found, "Usuário não existe")}
    end
  end

  def payload_login(attrs \\ %{}) do
    User.changeset_login(%User{}, attrs)
  end
end
