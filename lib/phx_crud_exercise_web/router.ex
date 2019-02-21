defmodule PhxCrudExerciseWeb.Router do
  use PhxCrudExerciseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

  end

  # scope "/", PhxCrudExerciseWeb do
  #   pipe_through :browser
  #
  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api", PhxCrudExerciseWeb do
    pipe_through :api


    resources "/users", UserController, only: [:create, :show]
    resources "/articles", ArticleController, except: [:new, :edit]
  end
end
