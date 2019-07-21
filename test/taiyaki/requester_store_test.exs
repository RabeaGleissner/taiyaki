defmodule Taiyaki.RequesterStoreTest do
  use ExUnit.Case, async: true
  alias Taiyaki.RequesterStore

  setup do
    store = start_supervised!(RequesterStore)
    %{store: store}
  end

  test "stores requester and tracked users", %{store: store} do
    requester_id = "UKBN393PY"
    tracked_user_id = "UJY4BAA03"
    assert RequesterStore.get(store, tracked_user_id) == nil

    RequesterStore.put(store, requester_id, tracked_user_id)
    assert RequesterStore.get(store, tracked_user_id) == [requester_id]
  end

  test "adds additional requester for existing tracked user", %{store: store} do
    requester_id = "UKBN393PY"
    second_requester_id = "DEIR123UJ"
    tracked_user_id = "UJY4BAA03"
    RequesterStore.put(store, requester_id, tracked_user_id)
    RequesterStore.put(store, second_requester_id, tracked_user_id)

    assert RequesterStore.get(store, tracked_user_id) == [second_requester_id, requester_id]
  end

  test "adds another tracked user with new requester"
  test "gets all requesters for a tracked user"
end
