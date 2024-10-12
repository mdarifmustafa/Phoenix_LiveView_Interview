defmodule InterviewWeb.HomeLive do
  use Phoenix.LiveView

  import Phoenix.Component # This import is necessary for using live components
  import InterviewWeb.FlashHelpers # Custom flash helpers if you have them

  def mount(_params, _session, socket) do
    sections =
      File.read!("./assets/converse/sections.json")
      |> Poison.decode!()

    socket = assign(socket, sections: sections)
    {:ok, socket}
  end

  def handle_event("select_section", %{"section_number" => section_number, "section_name" => section_name}, socket) do
    socket = put_flash(socket, :info, "Selected Section: #{section_name} (#{section_number})")
     # Redirect to the section route
     {:noreply, push_navigate(socket, to: "/#{URI.encode(section_name)}")}
  end
end
