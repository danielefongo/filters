defmodule Filters.Condition.Eq do
  use Filters.Condition.Generic

  def filter_callback({key, value}), do: dynamic([o], field(o, ^key) == ^value)
end
