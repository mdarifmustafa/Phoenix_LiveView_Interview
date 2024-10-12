defmodule InterviewWeb.ConverseHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use InterviewWeb, :html

  embed_templates "converse_html/*"
end
