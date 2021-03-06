defmodule PhxCrudExercise.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :age, :integer
    field :first_name, :string
    field :last_name, :string
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
    |> unique_constraint(:password_hash)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> assign_token
  end

  defp assign_token(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :password_hash, create_token())
      _ -> changeset
    end
  end

  defp create_token() do
    leng = "Netguru" |> String.to_charlist |> hd
    random_string(leng)
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
