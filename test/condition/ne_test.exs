defmodule Filters.Condition.NeTest do
  use ExUnit.Case
  use DbTest
  require Logger

  test "retrieve zero elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    results = find_with_condition(by(ne_all: [name: "foo"]))

    assert results == []
  end

  test "retrieve one element" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo2", surname: "bar2"}])

    [retrieved_sample | []] = find_with_condition(by(ne_all: [name: "foo", surname: "bar"]))

    assert retrieved_sample.name == "foo2"
  end

  test "retrieve two elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [first, second | []] = find_with_condition(by(ne_all: [name: "unknown_surname"]))

    assert first.surname == "bar"
    assert second.surname == "bar2"
  end
end
