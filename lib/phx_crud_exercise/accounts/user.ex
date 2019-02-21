defmodule PhxCrudExercise.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :age, :integer
    field :first_name, :string
    field :last_name, :string
    field :password, virtual: true
    field :password_hash, :string

    has_many :articles, PhxCrudExercise.Content.Article

    timestamps()
  end

  @required_fields ~w(first_name last_name age)a
  @optional_fields ~w(password_hash)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_inclusion(:age, 13..150)
    |> validate_required(@required_fields)
  end
end
