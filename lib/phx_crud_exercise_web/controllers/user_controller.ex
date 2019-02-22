defmodule PhxCrudExerciseWeb.UserController do
  use PhxCrudExerciseWeb, :controller

  alias PhxCrudExercise.Accounts
  alias PhxCrudExercise.Accounts.User

  action_fallback PhxCrudExerciseWeb.FallbackController


  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show_with_token.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

end
