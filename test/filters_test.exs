defmodule Filters.DummyTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "pass options to conditions" do
    filter(Sample, by %{
      Condition1 => [foo: 1],
      Condition2 => [bar: 2, baz: 3]
    })

    assert_receive [condition: 1, foo: 1]
    assert_receive [condition: 2, bar: 2, baz: 3]
  end
end

defmodule Condition1 do
  def run(data) do
    send(self(), Keyword.put(data, :condition, 1))
    true
  end
end

defmodule Condition2 do
  def run(data) do
    send(self(), Keyword.put(data, :condition, 2))
    true
  end
end
