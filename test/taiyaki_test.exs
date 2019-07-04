defmodule TaiyakiTest do
  use ExUnit.Case
  doctest Taiyaki

  test "greets the world" do
    assert Taiyaki.hello() == :world
  end
end
