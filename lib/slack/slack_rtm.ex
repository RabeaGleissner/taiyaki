defmodule Slack.SlackRtm do
  use Slack
  alias Taiyaki.RequesterStore

  def handle_connect(_, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    {status, user_id, requester, response_message} = Taiyaki.MessageHandler.handle_message(message)
    if status == :ok do
      subscribe_presence([user_id], slack)
      RequesterStore.put(:requester_store, requester, user_id)
    end
    send_message(response_message, message.channel, slack)
    {:ok, state}
  end

  def handle_event(presence_change = %{type: "presence_change", presence: "active"}, slack = _, state) do
    %{user: tracked_user} = presence_change
    requesters = RequesterStore.get(:requester_store, tracked_user)
    send_message("They just came online!", List.first(requesters), slack)
    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    send_message(text, channel, slack)
    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}

end
