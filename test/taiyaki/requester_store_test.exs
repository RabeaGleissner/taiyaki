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

end
