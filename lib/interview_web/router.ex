defmodule InterviewWeb.Router do
  use InterviewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {InterviewWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InterviewWeb do
    pipe_through :browser

    # get "/", PageController, :home
    # get "/:section_name", SectionController, :index
    # get "/:section_name/:converse_name", ConverseController, :index
    # get "/:section_name/:converse_name/:question_no", ConverseController, :index

    # Add LiveView route
    # live "/:section_name/:converse_name/:question_no", ConverseLive, :index
    live "/", HomeLive
    live "/:section_name", SectionLive
    live "/:section_name/:converse_name", ConverseLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", InterviewWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:interview, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: InterviewWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
