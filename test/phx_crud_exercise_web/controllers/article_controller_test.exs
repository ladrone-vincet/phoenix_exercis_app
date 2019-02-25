defmodule PhxCrudExerciseWeb.ArticleControllerTest do
  use PhxCrudExerciseWeb.ConnCase

  alias PhxCrudExercise.Content
  alias PhxCrudExercise.Content.Article
  alias PhxCrudExercise.Accounts

  @moduletag :article_controller_tests

  @create_attrs %{
    body: "some body",
    description: "some description",
    published: "2010-04-17T14:00:00Z",
    title: "some title",
  }
  @update_attrs %{
    body: "some updated body",
    description: "some updated description",
    published: "2011-05-18T15:01:01Z",
    title: "some updated title"
  }
  @invalid_attrs %{body: nil, description: nil, published: nil, title: nil}

  @create_user_attrs %{
    id: 7,
    age: 42,
    first_name: "some first_name",
    last_name: "some last_name"
  }

  def fixture(:article) do

    {:ok, article} = Content.create_article(@create_attrs, fixture(:user))
    article
  end

  def fixture(:user) do
    {:ok, user} = create_user()
    user
  end

  setup %{conn: conn} do
    new_conn = conn
    |> put_req_header("accept", "application/json")
    |> authorise_conn
    {:ok, conn: new_conn}
  end

  describe "index" do
    test "lists all articles", %{conn: conn} do
      conn = get(conn, Routes.article_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end


  describe "create article" do
    test "renders article when data is valid", %{conn: conn} do
      # IO.puts conn.assigns.user.first_name
      conn = post(conn, Routes.article_path(conn, :create), article: @create_attrs)
      assert %{"article" => %{"id" => id}} = json_response(conn, 201)["data"]

      # assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.article_path(conn, :show, id))

      assert %{"article" => %{
               "id" => _id,
               "body" => "some body",
               "description" => "some description",
               "published" => "2010-04-17T14:00:00Z",
               "title" => "some title",
               "owner" => %{"id" => _user_id}
             }} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.article_path(conn, :create), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article" do
    setup [:create_article]

    test "renders article when data is valid", %{conn: conn, article: %Article{} = article} do
      conn = put(conn, Routes.article_path(conn, :update, article), article: @update_attrs)
      assert %{"article" => %{"id" => _id}} = json_response(conn, 200)["data"]
      conn = get(conn, Routes.article_path(conn, :show, article))

      assert %{"article" => %{
               "id" => _id,
               "body" => "some updated body",
               "description" => "some updated description",
               "published" => "2011-05-18T15:01:01Z",
               "title" => "some updated title"
             }} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, article: article} do
      conn = put(conn, Routes.article_path(conn, :update, article), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete article" do
    setup [:create_article]

    test "deletes chosen article", %{conn: conn, article: article} do
      conn = delete(conn, Routes.article_path(conn, :delete, article))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.article_path(conn, :show, article))
      end
    end
  end

  defp create_article(_) do
    article = fixture(:article)
    {:ok, article: article}
  end

  defp create_user() do
    PhxCrudExercise.Accounts.create_user(@create_user_attrs)
  end

  defp authorise_conn(conn) do
    {:ok, user} = create_user()
    conn
    |> assign(:user, {:ok, user})
  end
end
