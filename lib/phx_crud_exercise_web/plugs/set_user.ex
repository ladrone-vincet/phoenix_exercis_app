defmodule  PhxCrudExerciseWeb.Plugs.SetUser do
  import Plug.Conn

  alias PhxCrudExercise.Accounts

  def init(_params) do
  end


  def call(conn, params) do
    conn
    |> attach_user_through_token(params)
  end

  defp attach_user_through_token(conn, _params) do
    cond do

    Map.has_key?(conn.assigns, "user") -> conn
    conn.assigns.user -> conn

    not Map.has_key?(conn.params, "token") ->
      assign(conn, :user, {:error, "Plese provide the token"})
    #
    true ->
    token = conn.params["token"]
      case Accounts.is_token_assigned(token) do
        {:ok, user} -> assign(conn, :user, {:ok, user})
        {:error, message} -> assign(conn, :user, {:error, message})
      end
    end
    #
    # else
    # conn
  end

end
