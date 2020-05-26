defmodule Filters.DummyTest do
  use ExUnit.Case
  use DbTest
  import Filters

  test "pass options to conditions" do
    filter(Sample, by %{
      [Condition1, :all] => [foo: 1],
      [Condition2, :any] => [bar: 2, baz: 3]
    })

    assert_receive [foo: 1, condition: 1, kind: :all]
    assert_receive [bar: 2, baz: 3, condition: 2, kind: :any]
  end
end

defmodule Condition1 do
  def run(kind, data) do
    send(self(), Keyword.merge(data, [condition: 1, kind: kind]))
    true
  end
end

defmodule Condition2 do
  def run(kind, data) do
    send(self(), Keyword.merge(data, [condition: 2, kind: kind]))
    true
  end
end
