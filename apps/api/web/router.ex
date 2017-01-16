defmodule Api.Router do
  use Api.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  #scope "/", Api do
  #    pipe_through :browser # Use the default browser stack
  #
  #  get "/", PageController, :index
  #end

  # Other scopes may use custom stacks.
  scope "/api", Api do
    pipe_through :api

    resources "/networkcollisions", NetworkCollisionController, only: [:index, :create]
    scope "/networkcollisions" do
      get "/:node_a/:node_b",NetworkCollisionController, :show
    end
  end
end
