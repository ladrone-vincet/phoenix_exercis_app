defmodule PhxCrudExercise.ContentTest do
  use PhxCrudExercise.DataCase

  alias PhxCrudExercise.Content

  describe "articles" do
    alias PhxCrudExercise.Content.Article

    @valid_attrs %{body: "some body", description: "some description", published: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{body: "some updated body", description: "some updated description", published: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{body: nil, description: nil, published: nil, title: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Content.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Content.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Content.create_article(@valid_attrs)
      assert article.body == "some body"
      assert article.description == "some description"
      assert article.published == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Content.update_article(article, @update_attrs)
      assert article.body == "some updated body"
      assert article.description == "some updated description"
      assert article.published == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_article(article, @invalid_attrs)
      assert article == Content.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Content.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Content.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Content.change_article(article)
    end
  end
end
