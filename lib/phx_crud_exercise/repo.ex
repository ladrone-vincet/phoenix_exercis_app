defmodule PhxCrudExercise.Repo do
  use Ecto.Repo,
    otp_app: :phx_crud_exercise,
    adapter: Ecto.Adapters.Postgres
end
