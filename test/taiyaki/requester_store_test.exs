defmodule Taiyaki.RequesterStoreTest do
  use ExUnit.Case, async: false
  alias Taiyaki.RequesterStore

  setup do
    {_, {_, pid}} = RequesterStore.start_link(:requester_store)
    on_exit fn ->
      Agent.stop(pid)
    end
    :ok
  end

  test "stores requester and tracked users" do
    requester_id = "UKBN393PY"
    tracked_user_id = "UJY4BAA03"
    assert RequesterStore.get(:requester_store, tracked_user_id) == nil

    RequesterStore.put(:requester_store, requester_id, tracked_user_id)
    assert RequesterStore.get(:requester_store, tracked_user_id) == [requester_id]
  end

  test "stores additional requester for existing tracked user" do
    requester_id = "UKBN393PY"
    second_requester_id = "DEIR123UJ"
    tracked_user_id = "UJY4BAA03"
    RequesterStore.put(:requester_store, requester_id, tracked_user_id)
    RequesterStore.put(:requester_store, second_requester_id, tracked_user_id)

    assert RequesterStore.get(:requester_store, tracked_user_id) == [second_requester_id, requester_id]
  end

  test "adds another tracked user with new requester" do
    requester_id = "UKBN393PY"
    second_requester_id = "DEIR123UJ"
    tracked_user_id = "UJY4BAA03"
    second_tracked_user_id = ""
    RequesterStore.put(:requester_store, requester_id, tracked_user_id)
    RequesterStore.put(:requester_store, second_requester_id, second_tracked_user_id)

    assert RequesterStore.get(:requester_store, tracked_user_id) == [requester_id]
    assert RequesterStore.get(:requester_store, second_tracked_user_id) == [second_requester_id]
  end
end
