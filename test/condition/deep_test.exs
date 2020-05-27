defmodule Filters.Condition.DeepTest do
  use ExUnit.Case
  use DbTest

  test "recursively apply conditions" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [sample | []] =
      find_with_condition(
        by(
          all_deep: [
            all_deep: [
              all_eq: [name: "foo"],
              all_ne: [surname: "bar2"]
            ]
          ]
        )
      )

    assert sample.name == "foo"
    assert sample.surname == "bar"
  end
end
