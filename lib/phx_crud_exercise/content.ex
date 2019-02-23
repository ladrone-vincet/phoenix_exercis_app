defmodule PhxCrudExercise.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias PhxCrudExercise.Repo

  alias PhxCrudExercise.Content.Article

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end


    @doc """
    Returns the list of articles with owners

    """
  def list_articles_with_owners do
    user_only = [:id, :first_name, :last_name, :age]

    query = from article in Article,
            join: user in assoc(article, :user),
            select: %{article: article, owner: map(user, ^user_only)}
    Repo.all(query)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)


  @doc """
  Gets a single article of the user with provided token.

  Returns nil if not found.
  """
  def does_article_belongs_to_token_owner?(token, id) do

    query = from article in Article,
            join: user in assoc(article, :user),
            where: user.password_hash == ^token and article.id == ^id,
            select: {article, user}
    query
    |> Repo.exists?
  end

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end


    @doc """
    Creates a article with attached user.

    """
  def create_article(attrs, user) do
    %Article{}
    |> Article.changeset(attrs)
    |> Ecto.Changeset.change(user_id: user.id)
    |> Repo.insert()

  end
  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{source: %Article{}}

  """
  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end
end
