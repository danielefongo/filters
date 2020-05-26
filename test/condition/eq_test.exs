defmodule Filters.Condition.EqTest do
  use ExUnit.Case
  use DbTest
  require Logger

  test "retrieve zero elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    results = find_with_condition(by(eq_all: [name: "unknown_name"]))

    assert results == []
  end

  test "retrieve one element" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [retrieved_sample | []] = find_with_condition(by(eq_all: [name: "foo", surname: "bar"]))

    assert retrieved_sample.name == "foo"
  end

  test "retrieve two elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [first, second | []] = find_with_condition(by(eq_all: [name: "foo"]))

    assert first.surname == "bar"
    assert second.surname == "bar2"
  end
end
