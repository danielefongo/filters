defmodule Filters.Take.AllTest do
  use ExUnit.Case
  use DbTest

  test "find with 0 fields returns all" do
    insert([
      %Sample{name: "foo", surname: "bar", age: 1},
      %Sample{name: "foo", surname: "bar", age: 2}
    ])

    result = find_matching(all_eq: [])

    assert length(result) == 2
  end

  test "find with 1 field" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    result = find_matching(all_eq: [name: "foo"])

    assert length(result) == 2
  end

  test "find with many fields" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    result = find_matching(all_eq: [name: "foo", surname: "bar"])

    assert length(result) == 1
  end
end
