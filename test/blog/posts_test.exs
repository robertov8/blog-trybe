defmodule Blog.PostsTest do
  use Blog.DataCase, async: true

  import Blog.Factory.Post

  alias Ecto.Changeset
  alias Blog.{Error, Posts, Posts.Post, Users, Users.User}
  alias Blog.Factory.User, as: UserFactory

  describe "list_posts/0" do
    setup [:user_fixture]

    test "when calling listing, return listing with a post", %{user: user} do
      params = build(:post_params)
      Posts.create_post(user, params)

      response = Posts.list_posts()

      assert [
               %Post{
                 title: "Agregando valor a esse post",
                 content: "Tudo isso aí é inveja",
                 image: nil
               }
             ] = response
    end

    test "when calling listing, return an empty list" do
      response = Posts.list_posts()

      expected_respose = []
      assert response == expected_respose
    end
  end

  describe "get_user_by_uuid/1" do
    setup [:post_fixture]

    test "when all parameters are valid, return post", %{post: post} do
      response = Posts.get_post_by_uuid(post.id)

      assert {:ok,
              %Post{
                title: "Agregando valor a esse post",
                content: "Tudo isso aí é inveja",
                image: nil,
                user: %User{
                  display_name: "Rei do Camarote",
                  email: "rei123@camarote.com",
                  image: "https://storage.googleapis.com/image.png"
                }
              }} = response
    end

    test "when all parameters are valid, return non-existent post" do
      response = Posts.get_post_by_uuid("375fdd7e-fffc-4b60-b926-06d3b31edc30")

      expected_response = {:error, %Error{message: "Post não existe", status: :not_found}}

      assert response == expected_response
    end
  end

  describe "create_post/2" do
    setup [:post_fixture]

    test "when all parameters are valid, return user", %{post: post} do
      assert %Post{
               content: "Tudo isso aí é inveja",
               image: nil,
               title: "Agregando valor a esse post",
               user: %User{
                 display_name: "Rei do Camarote",
                 email: "rei123@camarote.com",
                 password: "camarote123"
               }
             } = post
    end

    test "when title is invalid, return an error", %{user: user} do
      params = build(:post_params, %{title: nil})
      response = Posts.create_post(user, params)

      expected_response = %{title: ["is required"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when content is invalid, return an error", %{user: user} do
      params = build(:post_params, %{content: nil})
      response = Posts.create_post(user, params)

      expected_response = %{content: ["is required"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end
  end

  describe "update_post/2" do
    setup [:post_fixture]

    test "when all parameters are valid, return user", %{post: post} do
      assert %Post{
               content: "Tudo isso aí é inveja",
               image: nil,
               title: "Agregando valor a esse post",
               user: %User{
                 display_name: "Rei do Camarote",
                 email: "rei123@camarote.com",
                 password: "camarote123"
               }
             } = post

      new_params = build(:post_params, title: "Novo titulo", content: "Novo conteudo")
      assert {:ok, post} = Posts.update_post(post, new_params)

      assert %Post{
               content: "Novo conteudo",
               image: nil,
               title: "Novo titulo",
               user: %User{
                 display_name: "Rei do Camarote",
                 email: "rei123@camarote.com",
                 password: "camarote123"
               }
             } = post
    end

    test "when title is invalid, return an error", %{post: post} do
      new_params = build(:post_params, title: nil, content: "Novo conteudo")
      response = Posts.update_post(post, new_params)

      expected_response = %{title: ["is required"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when content is invalid, return an error", %{post: post} do
      new_params = build(:post_params, title: "Novo titulo", content: nil)
      response = Posts.update_post(post, new_params)

      expected_response = %{content: ["is required"]}

      assert {:error, %Changeset{} = changeset} = response
      assert errors_on(changeset) == expected_response
    end

    test "when a user has edit a post from another, return error", %{post: post} do
      params = UserFactory.build(:user_params, email: "rei@camarote.com.br")
      {:ok, user} = Users.create_user(params)

      response = Posts.get_post_by_user(user, post.id)

      expected_response = %Blog.Error{message: "Usuário não autorizado", status: :unauthorized}

      assert {:error, %Error{} = error} = response
      assert error == expected_response
    end
  end

  describe "list_posts_by_term/1" do
    setup [:user_fixture]

    test "when the search path has a value, return queried list", %{user: user} do
      params = build(:post_params, %{title: "um titulo maneiro aqui"})
      Posts.create_post(user, params)

      params = build(:post_params, %{content: "Um contendo maneiro aqui"})
      Posts.create_post(user, params)

      params = build(:post_params, %{content: "Um contendo maneiro"})
      Posts.create_post(user, params)

      response = Posts.list_posts_by_term("aqui")

      assert [
               %Post{
                 title: "um titulo maneiro aqui",
                 content: "Tudo isso aí é inveja",
                 image: nil
               },
               %Post{
                 title: "Agregando valor a esse post",
                 content: "Um contendo maneiro aqui",
                 image: nil
               }
             ] = response
    end

    test "when the search field does not have a value, return all posts", %{user: user} do
      params = build(:post_params, %{title: "um titulo maneiro aqui"})
      Posts.create_post(user, params)

      params = build(:post_params, %{content: "Um contendo maneiro aqui"})
      Posts.create_post(user, params)

      params = build(:post_params, %{content: "Um contendo maneiro"})
      Posts.create_post(user, params)

      response = Posts.list_posts_by_term("")

      assert [
               %Post{
                 title: "um titulo maneiro aqui",
                 content: "Tudo isso aí é inveja",
                 image: nil
               },
               %Post{
                 title: "Agregando valor a esse post",
                 content: "Um contendo maneiro aqui",
                 image: nil
               },
               %Post{
                 title: "Agregando valor a esse post",
                 content: "Um contendo maneiro",
                 image: nil
               }
             ] = response
    end
  end

  describe "delete_post/1" do
    setup [:post_fixture]

    test "when all parameters are valid, return post", %{post: post} do
      {:ok, post} = Posts.delete_post(post)

      assert %Post{
               content: "Tudo isso aí é inveja",
               image: nil,
               title: "Agregando valor a esse post",
               user: %User{
                 display_name: "Rei do Camarote",
                 email: "rei123@camarote.com",
                 password: "camarote123"
               }
             } = post
    end

    test "when all parameters are valid, return non-existent user", %{post: post} do
      Posts.delete_post(post)
      response = Posts.delete_post(post)

      expected_response = {:error, %Error{message: "Post não existe", status: :not_found}}

      assert response == expected_response
    end
  end
end
