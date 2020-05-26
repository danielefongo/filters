defmodule Filters.Take.AnyTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "find with 0 fields returns empty list" do
    insert([
      %Sample{name: "foo", surname: "bar", age: 1},
      %Sample{name: "foo", surname: "bar", age: 2}
    ])

    condition = by(eq_any: [])

    result = find_with_condition(condition)

    assert result == []
  end

  test "find with 1 field" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    condition = by(eq_any: [name: "foo"])

    result = find_with_condition(condition)

    assert length(result) == 2
  end

  test "find with many fields" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo2", surname: "bar2"}])

    condition = by(eq_any: [name: "foo", surname: "bar2"])

    result = find_with_condition(condition)

    assert length(result) == 2
  end
end
