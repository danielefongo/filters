defmodule Filters.Condition.GenericTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "repeat filter callback for each option" do
    filter(
      Sample,
      by(all_equal: [foo: 1, bar: 2])
    )

    assert_receive {:foo, 1}
    assert_receive {:bar, 2}
  end

  test "properly match using Condition and Take" do
    insert([
      %Sample{name: "foo", surname: "bar", age: 1},
      %Sample{name: "foo", surname: "baz", age: 2}
    ])

    condition = by(all_equal: [name: "foo"])

    [first, second | _] = find_with_condition(condition)

    assert first.surname == "bar"
    assert second.surname == "baz"
  end
end

defmodule Filters.Condition.Equal do
  use Filters.Condition.Generic

  def filter_callback({key, value}) do
    send(self(), {key, value})
    dynamic([o], field(o, ^key) == ^value)
  end
end
