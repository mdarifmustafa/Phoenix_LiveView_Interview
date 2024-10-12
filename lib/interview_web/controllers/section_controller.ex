defmodule InterviewWeb.SectionController do
  use InterviewWeb, :controller

  def index(conn, %{"section_name" => section_name}) do
    # Format section_name to lowercase
    section_name_lower = String.downcase(section_name)

    # Construct the path to the JSON file
    json_file_path = "./assets/converse/#{section_name_lower}.json"

    # Attempt to read the JSON file
    case File.read(json_file_path) do
      {:ok, json_content} ->
        section_data = Poison.decode!(json_content)

      conn
      |> put_resp_content_type("text/html", "utf-8")
      |> assign(:section_name, section_name)
      |> assign(:section_data, section_data)
      |> render("index.html", layout: false)

      {:error, _reason} ->
        # Handle the case where the file does not exist or cannot be read
        conn
        |> put_flash(:error, "Section not found.")
        |> redirect(to: "/")
    end
  end

  # def show(conn, %{"messenger" => messenger}) do
  #   conn
  #   |> put_flash(:error, "Something went wrong!")
  #   |> render("show.html", messenger: messenger)
  # end
end
