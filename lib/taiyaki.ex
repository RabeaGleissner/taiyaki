defmodule Taiyaki do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    slack_token = Application.get_env(:taiyaki, Taiyaki)[:token]

    children = [
      worker(Taiyaki.RequesterStore, [:start]),
      worker(Slack.Bot, [Slack.SlackRtm, [], slack_token])
    ]
    #use Registry to pass pid to requester store? https://m.alphasights.com/process-registry-in-elixir-a-practical-example-4500ee7c0dcc
    #https://elixirforum.com/t/helping-the-workers-of-a-supervisor-get-to-know-one-another/4172/11
    #or should slack bot own requester store 

    opts = [strategy: :one_for_one, name: Taiyaki.Supervisor]
    {:ok, _pid}= Supervisor.start_link(children, opts)
  end
end
