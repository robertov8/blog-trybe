defmodule BlogWeb.UserControllerTest do
  use BlogWeb.ConnCase, async: true

  import Blog.Factory.User

  alias BlogWeb.Auth.Guardian
  alias Ecto.UUID

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json; charset=utf-8")}
  end

  describe "auth" do
    setup [:authenticate]

    test "required user authentication on all actions", %{conn: conn} do
      Enum.each(
        [
          get(conn, Routes.user_path(conn, :index)),
          get(conn, Routes.user_path(conn, :show, UUID.generate())),
          delete(conn, Routes.user_path(conn, :delete))
        ],
        fn conn ->
          assert json_response(conn, 401)
          assert conn.halted
        end
      )
    end

    test "when all parameters are valid, return token", %{conn_auth: conn} do
      body = build(:login_body)

      conn = post(conn, Routes.user_path(conn, :login), body)

      assert %{"token" => token} = json_response(conn, :ok)

      assert {:ok,
              %{
                "aud" => "blog",
                "iss" => "blog",
                "typ" => "access"
              }} = Guardian.decode_and_verify(token)
    end

    test "when email is invalid, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{email: nil})

      conn = post(conn, Routes.user_path(conn, :login), body)

      expected_response = %{"message" => "\"email\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when password is invalid, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{password: nil})

      conn = post(conn, Routes.user_path(conn, :login), body)

      expected_response = %{"message" => "\"password\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the email is blank, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{email: ""})

      conn = post(conn, Routes.user_path(conn, :login), body)

      expected_response = %{"message" => "\"email\" is not allowed to be empty"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the password is blank, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{password: ""})

      conn = post(conn, Routes.user_path(conn, :login), body)

      expected_response = %{"message" => "\"password\" is not allowed to be empty"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the user is invalid or does not exist, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{email: "rei@camarote.com"})

      conn = post(conn, Routes.user_path(conn, :login), body)

      expected_response = %{"message" => "Campos inválidos"}

      assert json_response(conn, :bad_request) == expected_response

      body = build(:user_body, %{password: "camarote123"})

      conn = post(conn, Routes.user_path(conn, :login), body)

      expected_response = %{"message" => "Campos inválidos"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the session is expired, return error", context do
      conn =
        context
        |> authentication_expired()
        |> Keyword.get(:conn_auth)

      conn = get(conn, Routes.user_path(conn, :index))

      expected_response = %{"message" => "Token expirado ou inválido"}

      assert json_response(conn, :unauthorized) == expected_response
    end

    test "when token is invalid, return error", %{conn: conn} do
      token = UUID.generate()

      conn =
        conn
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> put_req_header("authorization", "Bearer #{token}")

      conn = get(conn, Routes.user_path(conn, :index))

      expected_response = %{"message" => "Token expirado ou inválido"}

      assert json_response(conn, :unauthorized) == expected_response
    end
  end

  describe "index" do
    setup [:authenticate]

    test "lists all users", %{conn_auth: conn} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert [
               %{
                 "displayName" => "Rei do Camarote",
                 "email" => "rei123@camarote.com",
                 "image" => "https://storage.googleapis.com/image.png"
               }
             ] = json_response(conn, 200)
    end
  end

  describe "create user" do
    setup [:authenticate]

    test "when all parameters are valid, return user", %{conn_auth: conn} do
      body = build(:user_body, %{email: "rei@camarote.com"})

      conn = post(conn, Routes.user_path(conn, :create), body)

      assert %{"token" => _token} = json_response(conn, :created)
    end

    test "when display_name is invalid, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{email: "rei@camarote.com", displayName: "Rei"})

      conn = post(conn, Routes.user_path(conn, :create), body)

      expected_response = %{
        "message" => "\"display_name\" length must be at last 8 characters long"
      }

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when email is invalid, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{email: "reicamararote"})

      conn = post(conn, Routes.user_path(conn, :create), body)

      expected_response = %{"message" => "\"email\" must be a valid email"}

      assert json_response(conn, :bad_request) == expected_response

      body = build(:user_body, %{email: "@camarote.com"})

      conn = post(conn, Routes.user_path(conn, :create), body)

      expected_response = %{"message" => "\"email\" must be a valid email"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the email is blank, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{email: ""})

      conn = post(conn, Routes.user_path(conn, :create), body)

      expected_response = %{"message" => "\"email\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the password is blank, return an error", %{conn_auth: conn} do
      body = build(:user_body, %{password: ""})

      conn = post(conn, Routes.user_path(conn, :create), body)

      expected_response = %{"message" => "\"password\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when registering a user exists, return an error", %{conn_auth: conn} do
      body = build(:user_body)

      conn = post(conn, Routes.user_path(conn, :create), body)

      expected_response = %{"message" => "Usuário já existe"}

      assert json_response(conn, :conflict) == expected_response
    end
  end

  describe "show" do
    setup [:authenticate]

    test "when all parameters are valid, return user", %{conn_auth: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :show, user.id))

      assert %{
               "displayName" => "Rei do Camarote",
               "email" => "rei123@camarote.com",
               "image" => "https://storage.googleapis.com/image.png"
             } = json_response(conn, :ok)
    end

    test "when all parameters are valid, return non-existent user", %{conn_auth: conn} do
      conn = get(conn, Routes.user_path(conn, :show, "375fdd7e-fffc-4b60-b926-06d3b31edc30"))

      expected_response = %{"message" => "Usuário não existe"}

      assert json_response(conn, :not_found) == expected_response
    end
  end

  describe "delete user" do
    setup [:authenticate]

    test "when all parameters are valid, return user", %{conn_auth: conn} do
      conn = delete(conn, Routes.user_path(conn, :delete))

      assert response(conn, :no_content)
    end

    test "when all parameters are valid, return non-existent user", %{conn_auth: conn} do
      delete(conn, Routes.user_path(conn, :delete))
      conn = delete(conn, Routes.user_path(conn, :delete))

      assert response(conn, :unauthorized)
    end
  end
end
