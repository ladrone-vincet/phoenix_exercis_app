defmodule PhxCrudExerciseWeb.ArticleController do
  use PhxCrudExerciseWeb, :controller
  require IEx

  alias PhxCrudExercise.Content
  alias PhxCrudExercise.Accounts
  alias PhxCrudExercise.Content.Article

  action_fallback PhxCrudExerciseWeb.FallbackController

  def index(conn, _params) do
    articles_with_users = Content.list_articles_with_owners()
    render(conn, "index_expanded.json", articles_with_users: articles_with_users)
    # articles = Content.list_articles()
    # render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    {:ok, user} = conn.assigns[:user]
      with {:ok, %Article{} = article} <- Content.create_article(article_params, user) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.article_path(conn, :show, article))
        |> render("show.json",article: article, owner: user)
      end
  end

  def show(conn, %{"id" => id}) do

    try do
      article = Content.get_article!(id)
      IO.inspect article
      owner = Accounts.get_user!(article.user_id)
      render(conn, "show.json", article: article, owner: owner)
    rescue
      _e in [Ecto.NoResultsError, ArgumentError] ->
        render_404(conn)
      end

  end


  def update(conn, %{"id" => id, "article" => article_params}) do
    force_ownership(conn, id)

    article = Content.get_article!(id)

    with {:ok, %Article{} = article} <- Content.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    force_ownership(conn, id)

    article = Content.get_article!(id)

    with {:ok, %Article{}} <- Content.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end

  defp force_ownership(conn, id) do
    {:ok, user} = conn.assigns[:user]
    is_owner = Content.does_article_belongs_to_token_owner?(user.password_hash, id)
    if is_owner do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(PhxCrudExerciseWeb.ErrorView)
      |> render("401.json", message: "You don't have permissions to affect this article.")
      |> halt()
    end
  end

  defp render_404(conn) do
    conn
    |> put_view(PhxCrudExerciseWeb.ErrorView)
    |> render("404.json")
    |> halt()
  end
end
