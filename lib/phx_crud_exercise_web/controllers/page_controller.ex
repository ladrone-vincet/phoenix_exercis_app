defmodule PhxCrudExerciseWeb.PageController do
  use PhxCrudExerciseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
