defmodule PhxCrudExerciseWeb.UserView do
  use PhxCrudExerciseWeb, :view
  alias PhxCrudExerciseWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("show_with_token", %{user: user}) do
    %{data: render_one(user, UserView, "user_with_token.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      age: user.age}
  end

  def render("user_with_token", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      age: user.age,
      token: user.password_hash}
    end
end
