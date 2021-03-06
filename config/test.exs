use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_crud_exercise, PhxCrudExerciseWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :debug

# Configure your database
config :phx_crud_exercise, PhxCrudExercise.Repo,
  username: "postgres",
  password: "postgres",
  database: "phx_crud_exercise_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
