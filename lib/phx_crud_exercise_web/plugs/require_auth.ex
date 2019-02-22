defmodule  PhxCrudExerciseWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    error_message = "You are not authorised. Please provide correct token."

    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(PhxCrudExerciseWeb.ErrorView)
      |> render("401.json", message: error_message)
      |> halt()
    end
  end

end
