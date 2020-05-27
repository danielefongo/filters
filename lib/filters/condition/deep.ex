defmodule Filters.Condition.Deep do
  @behaviour Filters.Behaviour.Condition

  import Filters

  @impl true
  def filter_callback(args), do: by([args])
end
