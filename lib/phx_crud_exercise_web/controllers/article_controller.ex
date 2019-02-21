defmodule PhxCrudExerciseWeb.ArticleController do
  use PhxCrudExerciseWeb, :controller

  alias PhxCrudExercise.Content
  alias PhxCrudExercise.Content.Article

  action_fallback PhxCrudExerciseWeb.FallbackController

  def index(conn, _params) do
    articles = Content.list_articles()
    raw_data = [
      %Article{title: "T", description: "desc", body: "Lorem ipsum dolor", published: DateTime.utc_now() }
    ]


    render(conn, "index.json", articles: articles ++ raw_data)
  end

  def create(conn, struct) do
    #IO.puts(struct)
    #IO.puts(article_params)
    with {:ok, %Article{} = article} <- Content.create_article(struct) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Content.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Content.get_article!(id)

    with {:ok, %Article{} = article} <- Content.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Content.get_article!(id)

    with {:ok, %Article{}} <- Content.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
