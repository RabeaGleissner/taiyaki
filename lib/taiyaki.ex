defmodule Taiyaki do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    slack_token = Application.get_env(:taiyaki, Taiyaki)[:token]

    children = [
      worker(Taiyaki.RequesterStore, [:start]),
      worker(Slack.Bot, [Slack.SlackRtm, [], slack_token])
    ]

    opts = [strategy: :one_for_one, name: Taiyaki.Supervisor]
    {:ok, _pid}= Supervisor.start_link(children, opts)
  end
end
