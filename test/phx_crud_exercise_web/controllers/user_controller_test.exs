defmodule PhxCrudExerciseWeb.UserControllerTest do
  use PhxCrudExerciseWeb.ConnCase

  alias PhxCrudExercise.Accounts

  @create_attrs %{
    age: 42,
    first_name: "some first_name",
    last_name: "some last_name"
  }

  @invalid_attrs %{age: nil, first_name: nil, last_name: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  @tag :individual_test
  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      IO.puts id
      user = Accounts.get_user!(id)
      auth_conn = conn |> assign(:user, user)

      IO.inspect json_response(conn, 200)["data"]
      conn = get(conn, Routes.user_path(conn, :show, id))
      assert %{
               "id" => id,
               "age" => 42,
               "first_name" => "some first_name",
               "last_name" => "some last_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end


  defp create_user() do
    user = fixture(:user)
    {:ok, user: user}
  end

  defp authorise_conn(conn) do
    {:ok, user} = create_user()
    conn
    |> assign(:user, {:ok, user})
  end
end
