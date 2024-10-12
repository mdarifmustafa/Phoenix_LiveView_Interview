defmodule InterviewWeb.FlashHelpers do
  use Phoenix.Component  # This ensures you can use HEEx features

  def flash_group(assigns) do
    ~H"""
    <div>
      <%= for {type, message} <- @flash do %>
        <div class={"flash flash-#{type}"}>
          <%= message %>
        </div>
      <% end %>
    </div>
    """
  end
end
