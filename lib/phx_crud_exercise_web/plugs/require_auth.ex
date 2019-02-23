defmodule  PhxCrudExerciseWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do

    case conn.assigns[:user] do
      {:ok, _user} -> conn
      {:error, message} -> conn
        |> put_status(:unauthorized)
        |> put_view(PhxCrudExerciseWeb.ErrorView)
        |> render("401.json", message: message)
        |> halt()
      nil -> conn
        |> put_status(:not_found)
        |> put_view(PhxCrudExerciseWeb.ErrorView)
        |> render("404.json")
        |> halt()
    end
  end

end
