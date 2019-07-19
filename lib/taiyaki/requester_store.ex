defmodule Taiyaki.RequesterStore do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  def get(store, tracked_user) do
    Agent.get(store, fn requesters -> Map.get(requesters, tracked_user) end)
  end

  def put(store, requester, tracked_user) do
    Agent.update(store, fn store -> Map.put(store, tracked_user, [requester]) end)
  end

end
