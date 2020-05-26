defmodule Filters.Condition.Null do
  use Filters.Condition.Generic

  def filter_callback(key), do: dynamic([o], is_nil(field(o, ^key)))
end
