defmodule InterviewWeb.ConverseLive do
  use Phoenix.LiveView

  import Phoenix.Component # This import is necessary for using live components
  # import InterviewWeb.FlashHelpers # Custom flash helpers if you have them
  # import Phoenix.VerifiedRoutes
  # alias InterviewWeb.Router.Helpers, as: Routes

  def mount(%{"section_name" => section_name, "converse_name" => converse_name} = params, _session, socket) do

    # Get the question_no parameter, defaulting to an empty string if not present
    question_no = Map.get(params, "question_no", "")
    show_group = false

    # Format section_name to lowercase
    converse_name_lower = String.downcase(converse_name)

    # Construct the path to the JSON file
    json_file_path = "./assets/converse/#{converse_name_lower}.json"

    case File.read(json_file_path) do
      {:ok, json_content} ->
        converse_data = Poison.decode!(json_content)

        groupsProp = Map.get(converse_data, "groups")
        answersProp = Map.get(converse_data, "answers")
        questionsProp = Map.get(converse_data, "questions")

        questions =
          questionsProp
          |> Enum.to_list() # Convert the map to a list of tuples
          |> Enum.sort_by(fn {key, _} -> String.to_integer(key) end)

        IO.inspect(show_group, label: "init show_group")

        socket =
          assign(socket, %{
            section_name: section_name,
            converse_name: converse_name,
            questions: questions,
            question_no: question_no,
            groups: groupsProp,
            answers: answersProp,
            show_group: show_group,
            converse_data: converse_data
          })
        {:ok, socket}

      {:error, _reason} ->
        # Handle error case by assigning an empty list or a default value
        socket = assign(socket, %{
          section_name: section_name,
          converse_name: converse_name,
          questions: [],
          question_no: question_no,
          groups: [],
          answers: [],
          show_group: show_group,
          converse_data: []
        })
        {:ok, socket}  # Return the socket
    end
  end

  def handle_event("select_question", %{"question_no" => question_no}, socket) do
    {:noreply, assign(socket, :question_no, question_no)}
  end

  def handle_event("navigate_to_section", %{"section_name" => section_name}, socket) do
    {:noreply, push_navigate(socket, to: "/#{URI.encode(section_name)}")}
  end

  def handle_event("previous_question", %{"question_no" => question_no}, socket) do
    if String.to_integer(question_no) > 1 do
      {:noreply, assign(socket, :question_no, Integer.to_string (String.to_integer(question_no) - 1))}
    else
      {:noreply, assign(socket, :question_no, question_no)}
    end
  end

  def handle_event("next_question", %{"question_no" => question_no, "total_questions" => total_questions}, socket) do
    no = String.to_integer(question_no)
    if no < String.to_integer(total_questions) do
      {:noreply, assign(socket, :question_no, Integer.to_string(no + 1))}
    else
      {:noreply, assign(socket, :question_no, question_no)}
    end
  end

  def handle_event("toggle_group", _params, socket) do
    {:noreply, assign(socket, :show_group, not socket.assigns.show_group)}
  end
end
