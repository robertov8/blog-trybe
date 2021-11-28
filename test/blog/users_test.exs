defmodule Blog.UsersTest do
  use Blog.DataCase, async: true

  import Blog.Factory.User

  alias Ecto.Changeset
  alias Blog.{Error, Users, Users.User}

  describe "list_users/0" do
    test "when calling listing, return listing with a user" do
      params = build(:user_params)
      Users.create_user(params)

      response = Users.list_users()

      assert [
               %User{
                 display_name: "Rei do Camarote",
                 email: "rei123@camarote.com",
                 image: "https://storage.googleapis.com/image.png"
               }
             ] = response
    end

    test "when calling listing, return an empty list" do
      response = Users.list_users()

      expected_respose = []
      assert response == expected_respose
    end
  end

  describe "get_user_by_uuid/1" do
    test "when all parameters are valid, return user" do
      params = build(:user_params)
      assert {:ok, user} = Users.create_user(params)

      response = Users.get_user_by_uuid(user.id)

      assert {:ok,
              %User{
                display_name: "Rei do Camarote",
                email: "rei123@camarote.com",
                image: "https://storage.googleapis.com/image.png",
                password: nil
              }} = response
    end

    test "when all parameters are valid, return non-existent user" do
      response = Users.get_user_by_uuid("375fdd7e-fffc-4b60-b926-06d3b31edc30")

      expected_response = {:error, %Error{message: "Usuário não existe", status: :not_found}}

      assert response == expected_response
    end
  end

  describe "create_user/1" do
    test "when all parameters are valid, return user" do
      params = build(:user_params)
      assert {:ok, user} = Users.create_user(params)

      assert %User{
               display_name: "Rei do Camarote",
               email: "rei123@camarote.com",
               image: "https://storage.googleapis.com/image.png",
               password: "camarote123"
             } = user
    end

    test "when display_name is invalid, return an error" do
      params = build(:user_params, %{display_name: "Rei"})
      response = Users.create_user(params)

      expected_response = %{display_name: ["length must be at last 8 characters long"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when email is invalid, return an error" do
      params = build(:user_params, %{email: "reicamararote"})
      response = Users.create_user(params)

      expected_response = %{email: ["must be a valid email"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response

      params = build(:user_params, %{email: "@camarote.com"})
      response = Users.create_user(params)

      expected_response = %{email: ["must be a valid email"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when the email is blank, return an error" do
      params = build(:user_params, %{email: ""})
      response = Users.create_user(params)

      expected_response = %{email: ["is required"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when password is invalid, return an error" do
      params = build(:user_params, %{password: "rei"})
      response = Users.create_user(params)

      expected_response = %{password: ["length must be 6 characters long"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when registering a user exists, return an error" do
      params = build(:user_params)

      Users.create_user(params)
      response = Users.create_user(params)

      expected_response = %{email: ["Usuário já existe"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end
  end

  describe "delete_user/1" do
    test "when all parameters are valid, return user" do
      params = build(:user_params)
      assert {:ok, user} = Users.create_user(params)

      response = Users.delete_user(user)

      assert {:ok,
              %User{
                display_name: "Rei do Camarote",
                email: "rei123@camarote.com",
                image: "https://storage.googleapis.com/image.png",
                password: "camarote123"
              }} = response
    end

    test "when all parameters are valid, return non-existent user" do
      params = build(:user_params)
      assert {:ok, user} = Users.create_user(params)

      Users.delete_user(user)
      response = Users.delete_user(user)

      expected_response = {:error, %Error{message: "Usuário não existe", status: :not_found}}

      assert response == expected_response
    end
  end
end
