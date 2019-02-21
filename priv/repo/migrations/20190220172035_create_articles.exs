defmodule PhxCrudExercise.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :string
      add :body, :string
      add :published, :utc_datetime, default: fragment("now()")
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
