defmodule InterviewWeb.ConverseController do
  use InterviewWeb, :controller

  # def index(conn, %{"section_name" => section_name, "converse_name" => converse_name, "question_no" => question_no}) do
  def index(conn, %{"section_name" => section_name, "converse_name" => converse_name} = params) do
    # Get the question_no parameter, defaulting to an empty string if not present
    question_no = Map.get(params, "question_no", "")
    show_group = Map.get(params, "show_group") == "true"

    # Format section_name to lowercase
    converse_name_lower = String.downcase(converse_name)

    # Construct the path to the JSON file
    json_file_path = "./assets/converse/#{converse_name_lower}.json"

    # Attempt to read the JSON file
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

      # questions = Map.sort(Map.new(questionsProp, fn {key, value} -> {Integer.parse(key), value} end), :ascending)

      conn
      |> put_resp_content_type("text/html", "utf-8")
      |> assign(:section_name, section_name)
      |> assign(:converse_name, converse_name)
      |> assign(:questions, questions)
      |> assign(:question_no, question_no)
      |> assign(:groups, groupsProp)
      |> assign(:answers, answersProp)
      |> assign(:show_group, show_group)
      |> assign(:converse_data, converse_data)
      |> render("index.html", layout: false)

      {:error, _reason} ->
        # Handle the case where the file does not exist or cannot be read
        conn
        |> put_flash(:error, "Q and A not found.")
        |> redirect(to: "/")
    end
  end
end
