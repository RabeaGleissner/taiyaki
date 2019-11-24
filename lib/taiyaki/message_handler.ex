defmodule Taiyaki.MessageHandler do
  def handle_message(message) do
    message
    |> parse_message
    |> create_response
  end

  defp parse_message(%{text: text, user: user}) do
    if String.contains?(text, "Where is") do
      "Where is " <> tracked_user_id = text
      {:ok, tracked_user_id, user}
    else
      {:invalid, ""}
    end
  end

  defp create_response({:ok, tracked_user_id, user}) do
    [_, rest] = String.split(tracked_user_id, "@")
    [clean_user_id, _] = String.split(rest, ">")

    {:ok, clean_user_id, user, "I'll let you know when #{tracked_user_id} comes online"}
  end

  defp create_response({:invalid, _}), do: {:invalid, "", "", "This is beyond my capabilities!"}
end
