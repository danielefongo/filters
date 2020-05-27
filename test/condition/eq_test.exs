defmodule Filters.Condition.EqTest do
  use ExUnit.Case
  use DbTest
  require Logger

  test "retrieve zero elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    results = find_matching(all_eq: [name: "unknown_name"])

    assert results == []
  end

  test "retrieve one element" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [retrieved_sample | []] = find_matching(all_eq: [name: "foo", surname: "bar"])

    assert retrieved_sample.name == "foo"
  end

  test "retrieve two elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [first, second | []] = find_matching(all_eq: [name: "foo"])

    assert first.surname == "bar"
    assert second.surname == "bar2"
  end
end
