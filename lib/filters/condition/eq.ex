defmodule Filters.Condition.Eq do
  @behaviour Filters.Behaviour.Condition

  import Ecto.Query

  @impl true
  def filter_callback({key, value}), do: dynamic([o], field(o, ^key) == ^value)
end
