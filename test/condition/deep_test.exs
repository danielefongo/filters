defmodule Filters.Condition.DeepTest do
  use ExUnit.Case
  use DbTest
  alias Filters.Condition.Deep

  test "recursively apply conditions" do
    insert([%Sample{name: "foo", surname: "bar"}, %Sample{name: "foo", surname: "bar2"}])

    [sample | []] =
      find_with_condition(
        by(%{
          [Deep, :all] => %{
            [Deep, :all] => %{
              [Equal, :all] => [name: "foo"],
              [NotEqual, :all] => [surname: "bar2"]
            }
          }
        })
      )

    assert sample.name == "foo"
    assert sample.surname == "bar"
  end
end

defmodule Equal do
  use Filters.Condition.Generic

  def filter_callback({key, value}), do: dynamic([o], field(o, ^key) == ^value)
end

defmodule NotEqual do
  use Filters.Condition.Generic

  def filter_callback({key, value}), do: dynamic([o], field(o, ^key) != ^value)
end
