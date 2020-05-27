defmodule Filters.Condition.NullTest do
  use ExUnit.Case
  use DbTest

  test "retrieve zero elements" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    results = find_with_condition(by(all_null: [:name]))

    assert results == []
  end

  test "retrieve one element" do
    insert([%Sample{name: nil, surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [retrieved_sample | []] = find_with_condition(by(all_null: [:name]))

    assert retrieved_sample.name == nil
    assert retrieved_sample.surname == "bar"
  end

  test "retrieve two elements" do
    insert([%Sample{name: nil, surname: "bar"}, %Sample{name: nil, surname: "bar2"}])

    [first, second | []] = find_with_condition(by(all_null: [:name]))

    assert first.surname == "bar"
    assert second.surname == "bar2"
  end
end
