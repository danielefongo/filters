defmodule Filters.Condition.DeepTest do
  use ExUnit.Case
  use DbTest

  test "recursively apply conditions" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [sample | []] =
      find_with_condition(
        by(
          deep_all: [
            deep_all: [
              eq_all: [name: "foo"],
              ne_all: [surname: "bar2"]
            ]
          ]
        )
      )

    assert sample.name == "foo"
    assert sample.surname == "bar"
  end
end
