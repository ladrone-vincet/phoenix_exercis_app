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

  pipeline :process_token do
    # plug Plug.fetch_body_params
    plug Plug.Parsers, [parsers: [:urlencoded, :json],
                   pass: ["text/*"],
                   json_decoder: Jason]
    plug PhxCrudExerciseWeb.Plugs.SetUser
    plug PhxCrudExerciseWeb.Plugs.RequireAuth
  end

  # scope "/", PhxCrudExerciseWeb do
  #   pipe_through :browser
  #
  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.


  scope "/api", PhxCrudExerciseWeb do
    pipe_through [:api, :process_token]

    resources "/users", UserController, only: [:show]
    resources "/articles", ArticleController, except: [:new, :edit, :index, :show]

  end

  scope "/api", PhxCrudExerciseWeb do
    pipe_through [:api]

    resources "/articles", ArticleController, only: [:index, :show]
    resources "/users", UserController, only: [:create]

    # get "/*path", ErrorView, status: :not_found
  end
end
