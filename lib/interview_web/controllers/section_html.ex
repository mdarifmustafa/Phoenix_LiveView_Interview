defmodule InterviewWeb.SectionHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use InterviewWeb, :html

  embed_templates "section_html/*"
end
