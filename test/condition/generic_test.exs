defmodule Filters.Condition.GenericTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "repeat filter callback for each option" do
    filter(
      Sample,
      by(%{
        [Equal, :all] => [foo: 1, bar: 2]
      })
    )

    assert_receive {:foo, 1}
    assert_receive {:bar, 2}
  end

  describe "match all" do
    test "find with 0 fields returns all" do
      insert([
        %Sample{name: "foo", surname: "bar", age: 1},
        %Sample{name: "foo", surname: "bar", age: 2}
      ])

      condition =
        by(%{
          [Equal, :all] => []
        })

      result = find_with_condition(condition)

      assert length(result) == 2
    end

    test "find with 1 field" do
      insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

      condition =
        by(%{
          [Equal, :all] => [name: "foo"]
        })

      result = find_with_condition(condition)

      assert length(result) == 2
    end

    test "find with many fields" do
      insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

      condition =
        by(%{
          [Equal, :all] => [name: "foo", surname: "bar"]
        })

      result = find_with_condition(condition)

      assert length(result) == 1
    end
  end

  describe "match any" do
    test "find with 0 fields returns empty list" do
      insert([
        %Sample{name: "foo", surname: "bar", age: 1},
        %Sample{name: "foo", surname: "bar", age: 2}
      ])

      condition =
        by(%{
          [Equal, :any] => []
        })

      result = find_with_condition(condition)

      assert length(result) == 0
    end

    test "find with 1 field" do
      insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

      condition =
        by(%{
          [Equal, :any] => [name: "foo"]
        })

      result = find_with_condition(condition)

      assert length(result) == 2
    end

    test "find with many fields" do
      insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo2", surname: "bar2"}])

      condition =
        by(%{
          [Equal, :any] => [name: "foo", surname: "bar2"]
        })

      result = find_with_condition(condition)

      assert length(result) == 2
    end
  end

  describe "match none" do
    test "find with 0 fields returns all" do
      insert([
        %Sample{name: "foo", surname: "bar", age: 1},
        %Sample{name: "foo", surname: "bar", age: 2}
      ])

      condition =
        by(%{
          [Equal, :none] => []
        })

      result = find_with_condition(condition)

      assert length(result) == 2
    end

    test "find with 1 field" do
      insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

      condition =
        by(%{
          [Equal, :none] => [name: "foo"]
        })

      result = find_with_condition(condition)

      assert length(result) == 0
    end

    test "find with many fields" do
      insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo2", surname: "bar2"}])

      condition =
        by(%{
          [Equal, :none] => [name: "foo", surname: "bar"]
        })

      result = find_with_condition(condition)

      assert length(result) == 1
    end
  end
end

defmodule Equal do
  use Filters.Condition.Generic

  def filter_callback({key, value}) do
    send(self(), {key, value})
    dynamic([o], field(o, ^key) == ^value)
  end
end
