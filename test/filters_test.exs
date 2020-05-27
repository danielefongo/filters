defmodule FiltersTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "pass options to each condition" do
    filter(
      Sample,
      by(
        all_condition1: [foo: "foo"],
        all_condition2: [bar: 2, baz: 3]
      )
    )

    assert_receive condition: 1, data: {:foo, "foo"}
    assert_receive condition: 2, data: {:bar, 2}
    assert_receive condition: 2, data: {:baz, 3}
  end

  test "pass options to take" do
    filter(
      Sample,
      by(take1_condition1: [bar: 2, baz: 3])
    )

    fun = &Filters.Condition.Condition1.filter_callback/1

    assert_receive {[bar: 2, baz: 3], ^fun}
  end

  test "properly match using Condition and Take" do
    insert([
      %Sample{name: "foo", surname: "bar", age: 1},
      %Sample{name: "foo", surname: "baz", age: 2}
    ])

    condition = by(all_eq: [name: "foo"])

    [first, second | _] = find_with_condition(condition)

    assert first.surname == "bar"
    assert second.surname == "baz"
  end
end

defmodule Filters.Take.Take1 do
  def run(data, filter) do
    send(self(), {data, filter})
    true
  end
end

defmodule Filters.Condition.Condition1 do
  @behaviour Filters.Behaviour.Condition

  @impl true
  def filter_callback(data) do
    send(self(), condition: 1, data: data)
    true
  end
end

defmodule Filters.Condition.Condition2 do
  @behaviour Filters.Behaviour.Condition

  @impl true
  def filter_callback(data) do
    send(self(), condition: 2, data: data)
    true
  end
end
