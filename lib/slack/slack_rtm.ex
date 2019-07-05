defmodule Slack.SlackRtm do
  use Slack

  def handle_connect(slack, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    {_, user_id, response_message} = Taiyaki.MessageHandler.handle_message(message, slack.users)
    subscribe_presence([user_id], slack)
    send_message(response_message, message.channel, slack)
    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    send_message(text, channel, slack)
    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}

end
