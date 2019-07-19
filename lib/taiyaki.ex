defmodule Taiyaki do
  use Application

  def start(_type, _args) do
    Taiyaki.Supervisor.start_link(name: Taiyaki.Supervisor)
  end
end
