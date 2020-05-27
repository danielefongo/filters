defmodule Filters.Condition.Null do
  @behaviour Filters.Behaviour.Condition

  import Ecto.Query

  @impl true
  def filter_callback(key), do: dynamic([o], is_nil(field(o, ^key)))
end
