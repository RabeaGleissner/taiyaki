defmodule Taiyaki.MessageHandler do
  def handle_message(message, _) do
    message
    |> parse_message
    |> create_response
  end

  defp parse_message(%{text: text}) do
    if String.contains?(text, "Where is") do
      "Where is " <> user_id = text
      {:ok, user_id}
    else
      {:invalid, ""}
    end
  end

  defp create_response({:ok, user_id}) do
    [_, rest] = String.split(user_id, "@")
    [clean_user_id, _] = String.split(rest, ">")

    {:ok, clean_user_id, "I'll let you know when #{user_id} comes online"}
  end

  defp create_response({:invalid, _}), do: {:invalid, "", "This is beyond my capabilities!"}
end
