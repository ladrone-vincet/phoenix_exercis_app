defmodule PhxCrudExercise.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:password_hash])
  end
end
