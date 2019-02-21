defmodule PhxCrudExercise.Content.Article do
  use Ecto.Schema
  import Ecto.Changeset


  schema "articles" do
    field :title, :string
    field :description, :string
    field :body, :string
    field :published, :utc_datetime

    belongs_to :user, PhxCrudExercise.Accounts.User

    timestamps()
  end

  @required_fields ~w(title description body)a
  @optional_fields ~w(published)a

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_length(:title, min: 1, max: 150)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end
