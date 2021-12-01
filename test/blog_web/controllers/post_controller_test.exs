defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase, async: true

  import Blog.Factory.Post

  alias Ecto.UUID
  alias Blog.{Factory, Posts, Users}
  alias Factory.User, as: UserFactory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "auth" do
    setup [:authenticate]

    test "required user authentication on all actions", %{conn: conn} do
      Enum.each(
        [
          get(conn, Routes.post_path(conn, :search)),
          get(conn, Routes.post_path(conn, :index)),
          get(conn, Routes.post_path(conn, :show, UUID.generate())),
          post(conn, Routes.post_path(conn, :create)),
          patch(conn, Routes.post_path(conn, :update, UUID.generate())),
          put(conn, Routes.post_path(conn, :update, UUID.generate())),
          delete(conn, Routes.post_path(conn, :delete, UUID.generate()))
        ],
        fn conn ->
          assert json_response(conn, 401)
          assert conn.halted
        end
      )
    end

    test "when the session is expired, return error", context do
      conn =
        context
        |> authentication_expired()
        |> Keyword.get(:conn_auth)

      conn = get(conn, Routes.post_path(conn, :index))

      expected_response = %{"message" => "Token expirado ou inválido"}

      assert json_response(conn, :unauthorized) == expected_response
    end

    test "when token is invalid, return error", %{conn: conn} do
      token = UUID.generate()

      conn =
        conn
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> put_req_header("authorization", "Bearer #{token}")

      conn = get(conn, Routes.post_path(conn, :index))

      expected_response = %{"message" => "Token expirado ou inválido"}

      assert json_response(conn, :unauthorized) == expected_response
    end
  end

  describe "index" do
    setup [:authenticate]

    test "lists all posts", %{conn_auth: conn, user: user} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert [] = json_response(conn, 200)

      params = build(:post_params)
      Posts.create_post(user, params)

      conn = get(conn, Routes.post_path(conn, :index))

      assert [
               %{
                 "content" => "Tudo isso aí é inveja",
                 "title" => "Agregando valor a esse post",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               }
             ] = json_response(conn, 200)
    end
  end

  describe "create user" do
    setup [:authenticate]

    test "when all parameters are valid, return user", %{conn_auth: conn} do
      body = build(:post_params)

      conn = post(conn, Routes.post_path(conn, :create), body)

      assert %{
               "title" => "Agregando valor a esse post"
             } = json_response(conn, :created)
    end

    test "when title is invalid, return an error", %{conn_auth: conn} do
      body = build(:post_params, %{title: nil})

      conn = post(conn, Routes.post_path(conn, :create), body)

      expected_response = %{"message" => "\"title\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when content is invalid, return an error", %{conn_auth: conn} do
      body = build(:post_params, %{content: nil})

      conn = post(conn, Routes.post_path(conn, :create), body)

      expected_response = %{"message" => "\"content\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when the title is blank, return an error", %{conn_auth: conn} do
      body = build(:post_params, %{title: ""})

      conn = post(conn, Routes.post_path(conn, :create), body)

      expected_response = %{"message" => "\"title\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end
  end

  describe "show" do
    setup [:authenticate, :post_fixture]

    test "when all parameters are valid, return user", %{conn_auth: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :show, post.id))

      assert %{
               "content" => "Tudo isso aí é inveja",
               "title" => "Agregando valor a esse post",
               "user" => %{
                 "displayName" => "Rei do Camarote",
                 "email" => "rei123@camarote.com",
                 "image" => "https://storage.googleapis.com/image.png"
               }
             } = json_response(conn, :ok)
    end

    test "when all parameters are valid, return non-existent user", %{conn_auth: conn} do
      conn = get(conn, Routes.post_path(conn, :show, "375fdd7e-fffc-4b60-b926-06d3b31edc30"))

      expected_response = %{"message" => "Post não existe"}

      assert json_response(conn, :not_found) == expected_response
    end
  end

  describe "update post" do
    setup [:authenticate, :post_fixture]

    test "when all parameters are valid, return user", %{conn_auth: conn, post: post} do
      body = build(:post_params, %{title: "Novo conteudo", content: "Novo conteudo"})

      conn = put(conn, Routes.post_path(conn, :update, post.id), body)

      assert %{"title" => "Novo conteudo"} = json_response(conn, :ok)
    end

    test "when title is invalid, return an error", %{conn_auth: conn, post: post} do
      body = build(:post_params, %{title: nil, content: "Novo conteudo"})

      conn = put(conn, Routes.post_path(conn, :update, post.id), body)

      expected_response = %{"message" => "\"title\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when title is content, return an error", %{conn_auth: conn, post: post} do
      body = build(:post_params, %{title: "Novo titulo", content: nil})

      conn = put(conn, Routes.post_path(conn, :update, post.id), body)

      expected_response = %{"message" => "\"content\" is required"}

      assert json_response(conn, :bad_request) == expected_response
    end

    test "when a user has edit a post from another, return error", %{conn: conn, post: post} do
      params = UserFactory.build(:user_params, email: "rei@camarote.com.br")
      {:ok, user} = Users.create_user(params)

      conn_new =
        %{conn: conn, user: user}
        |> authenticate()
        |> Keyword.get(:conn_auth)

      body = build(:post_params, %{title: "Novo titulo", content: "Novo conteudo"})

      conn_new = put(conn_new, Routes.post_path(conn_new, :update, post.id), body)

      expected_response = %{"message" => "Usuário não autorizado"}

      assert json_response(conn_new, :unauthorized) == expected_response
    end
  end

  describe "search" do
    setup [:authenticate, :post_fixture]

    test "when all parameters are valid, return user", %{conn_auth: conn} do
      body = build(:post_params, %{title: "um titulo maneiro aqui"})
      post(conn, Routes.post_path(conn, :create), body)

      body = build(:post_params, %{content: "Um contendo maneiro aqui"})
      post(conn, Routes.post_path(conn, :create), body)

      body = build(:post_params, %{content: "Um contendo maneiro"})
      post(conn, Routes.post_path(conn, :create), body)

      query_string = %{"q" => "aqui"}
      conn = get(conn, Routes.post_path(conn, :search, query_string))

      assert [
               %{
                 "content" => "Tudo isso aí é inveja",
                 "title" => "um titulo maneiro aqui",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               },
               %{
                 "content" => "Um contendo maneiro aqui",
                 "title" => "Agregando valor a esse post",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               }
             ] = json_response(conn, :ok)
    end

    test "when the search field does not have a value, return all posts", %{conn_auth: conn} do
      body = build(:post_params, %{title: "um titulo maneiro aqui"})
      post(conn, Routes.post_path(conn, :create), body)

      body = build(:post_params, %{content: "Um contendo maneiro aqui"})
      post(conn, Routes.post_path(conn, :create), body)

      body = build(:post_params, %{content: "Um contendo maneiro"})
      post(conn, Routes.post_path(conn, :create), body)

      query_string = %{"q" => ""}
      conn = get(conn, Routes.post_path(conn, :search, query_string))

      assert [
               %{
                 "content" => "Tudo isso aí é inveja",
                 "title" => "Agregando valor a esse post",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               },
               %{
                 "content" => "Tudo isso aí é inveja",
                 "title" => "um titulo maneiro aqui",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               },
               %{
                 "content" => "Um contendo maneiro aqui",
                 "title" => "Agregando valor a esse post",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               },
               %{
                 "content" => "Um contendo maneiro",
                 "title" => "Agregando valor a esse post",
                 "user" => %{
                   "displayName" => "Rei do Camarote",
                   "email" => "rei123@camarote.com",
                   "image" => "https://storage.googleapis.com/image.png"
                 }
               }
             ] = json_response(conn, :ok)
    end
  end

  describe "delete post" do
    setup [:authenticate, :post_fixture]

    test "when all parameters are valid, return user", %{conn_auth: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post.id))

      assert response(conn, :no_content)
    end

    test "when all parameters are valid, return non-existent user", %{conn_auth: conn, post: post} do
      delete(conn, Routes.post_path(conn, :delete, post.id))
      conn = delete(conn, Routes.post_path(conn, :delete, post.id))

      expected_response = %{"message" => "Post não existe"}

      assert json_response(conn, :not_found) == expected_response
    end
  end
end
