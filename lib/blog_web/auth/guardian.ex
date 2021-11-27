defmodule BlogWeb.Auth.Guardian do
  use Guardian, otp_app: :blog

  alias Blog.{Error, Users, Users.User}

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}), do: Users.get_user_by(%{id: id})

  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Users.get_user_by(%{email: email}),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, get_opts()) do
      {:ok, token}
    else
      _ ->
        {:error, Error.build(:bad_request, "Campos inválidos")}
    end
  end

  defp get_opts do
    Application.get_env(:blog, :guardian_opts)
  end
end
