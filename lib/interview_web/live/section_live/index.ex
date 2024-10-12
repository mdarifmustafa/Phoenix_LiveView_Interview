defmodule InterviewWeb.SectionLive do
  use Phoenix.LiveView

  import Phoenix.Component # This import is necessary for using live components
  # import InterviewWeb.FlashHelpers # Custom flash helpers if you have them

  # def mount(%{"section_name" => section_name}, _session, socket) do

  #   # Format section_name to lowercase
  #   section_name_lower = String.downcase(section_name)

  #   # Construct the path to the JSON file
  #   json_file_path = "./assets/converse/#{section_name_lower}.json"

  #   case File.read(json_file_path) do
  #     {:ok, json_content} -> section_data = Poison.decode!(json_content)
  #     {:error, _reason} -> section_data = []

  #     socket = assign(socket, section_name: section_name, section_data: section_data)
  #     {:ok, socket}

  #   end
  # end
  def mount(%{"section_name" => section_name}, _session, socket) do
    # Format section_name to lowercase
    section_name_lower = String.downcase(section_name)

    # Construct the path to the JSON file
    json_file_path = "./assets/converse/#{section_name_lower}.json"

    # Read the JSON file and decode it
    case File.read(json_file_path) do
      {:ok, json_content} ->
        section_data = Poison.decode!(json_content)
        # Assign both section_name and section_data to the socket
        socket = assign(socket, section_name: section_name, section_data: section_data)
        {:ok, socket}  # Return the socket

      {:error, _reason} ->
        # Handle error case by assigning an empty list or a default value
        socket = assign(socket, section_name: section_name, section_data: [])
        {:ok, socket}  # Return the socket
    end
  end

  def handle_event("select_section", %{"section_number" => section_number, "section_name" => section_name}, socket) do
    socket = put_flash(socket, :info, "Selected Section: #{section_name} (#{section_number})")

     # Redirect to the section route
     {:noreply, push_navigate(socket, to: "/#{URI.encode(section_name)}")}
  end
end
