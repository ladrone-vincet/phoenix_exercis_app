defmodule PhxCrudExerciseWeb.SetUserPlugTest do
  use PhxCrudExerciseWeb.ConnCase
  use Plug.Test


  describe "conn interaction" do
    test "catch the token" do
      conn = build_conn()
      |> put_peer_data('{"token"="pass"}')
      |> PhxCrudExerciseWeb.Plugs.SetUser

      match?(conn.assigns[:user], {:ok, _}) |> assert
    end

  end


end
