defmodule ApiaiTest do
  use ExUnit.Case
  doctest Apiai

  test "greets the world" do
    assert Apiai.hello() == :world
  end
end
