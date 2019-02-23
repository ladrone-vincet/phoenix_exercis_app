defmodule PhxCrudExerciseWeb.ArticleView do
  use PhxCrudExerciseWeb, :view
  alias PhxCrudExerciseWeb.ArticleView
  alias PhxCrudExerciseWeb.UserView
  require IEx

  def render("index_expanded.json", %{articles_with_users: articles_with_users}) do
    # IEx.pry
    data = Enum.map(articles_with_users, fn art ->
      render(ArticleView, "show.json", %{article: art.article, owner: art.owner})
    end)
    %{data: data}
    # %{data: render_many(articles_with_users, ArticleView, "article_expanded.json")}
  end

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, ArticleView, "article.json")}
  end


  def render("show.json", %{article: article, owner: owner}) do
    %{data: render_one(article, ArticleView, "article_expanded.json", owner: owner)}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article_expanded.json", %{article: article, owner: owner}) do
    %{article: %{
        id: article.id,
        title: article.title,
        description: article.description,
        body: article.body,
        published: article.published,
        owner: render_one(owner, UserView, "user.json")
        }
    }
  end


  def render("article.json", %{article: article}) do
    %{article: %{
        id: article.id,
        title: article.title,
        description: article.description,
        body: article.body,
        published: article.published,
        user_id: article.user_id
        }
    }
  end
end
