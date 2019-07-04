defmodule SlackRtm do
  use Slack

  def handle_connect(slack, state) do
    IO.puts("Connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    send_message("Hello! I'm the bot", message.channel, slack)
    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts("Sending message")

    send_message(text, channel, slack)

    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}
  end
