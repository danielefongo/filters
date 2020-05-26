defmodule Filters.Condition.GenericTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "repeat filter callback for each option" do
    filter(
      Sample,
      by(%{
        [SpecificCondition, :all] => [foo: 1, bar: 2]
      })
    )

    assert_receive {:foo, 1}
    assert_receive {:bar, 2}
  end
end

defmodule SpecificCondition do
  use Filters.Condition.Generic

  def filter_callback(data) do
    send(self(), data)
    true
  end
end
