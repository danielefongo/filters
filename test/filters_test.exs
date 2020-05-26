defmodule FiltersTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "pass options to conditions" do
    filter(
      Sample,
      by([
        condition1_all: [foo: 1],
        condition2_any: [bar: 2, baz: 3]
      ])
    )

    assert_receive foo: 1, condition: 1, take: Filters.Take.All
    assert_receive bar: 2, baz: 3, condition: 2, take: Filters.Take.Any
  end
end

defmodule Filters.Condition.Condition1 do
  def run(take, data) do
    send(self(), Keyword.merge(data, condition: 1, take: take))
    true
  end
end

defmodule Filters.Condition.Condition2 do
  def run(take, data) do
    send(self(), Keyword.merge(data, condition: 2, take: take))
    true
  end
end
