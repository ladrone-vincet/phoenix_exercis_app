defmodule  PhxCrudExerciseWeb.Plugs.SetUser do
  import Plug.Conn

  alias PhxCrudExercise.Accounts

  def init(_params) do
  end


  def call(conn, %{"token" => token}) do
    IO.puts(token)
    IO.puts("call1")
    if conn.assigns[:user] do
      conn
    else
      case Accounts.is_token_assigned(token) do
        {:ok, user} -> assign(conn, :user, user)
        {:error, _} -> assign(conn, :user, nil)
      end
    end
  end

  def call(conn, params) do
    IO.puts(params)
    IO.puts("call2")
    assign(conn, :user, nil)
    conn
  end

end
