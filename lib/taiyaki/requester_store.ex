defmodule Taiyaki.RequesterStore do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: :requester_store)
  end

  def get(store, tracked_user) do
    Agent.get(store, fn requesters -> Map.get(requesters, tracked_user) end)
  end

  def put(store, requester, tracked_user) do
    IO.puts("&&&&&&&&&&&&")
    IO.inspect(store)
    current_requesters = Agent.get(store, fn requesters -> Map.get(requesters, tracked_user) end)
    if current_requesters do
      Agent.update(store, fn store -> Map.put(store, tracked_user, [requester | current_requesters]) end)
    else
      Agent.update(store, fn store -> Map.put(store, tracked_user, [requester]) end)
    end
  end

end
