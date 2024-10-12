defmodule InterviewWeb.PageController do
  use InterviewWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    # Read the JSON file and decode it
    sections =
      File.read!("./assets/converse/sections.json")
      |> Poison.decode!()

    # Render the home page with the sections data
    # render(conn, :home, layout: false, sections: sections)
    render(conn, :home, layout: false, sections: sections)
    # render(conn, :home, layout: false)
  end
end
