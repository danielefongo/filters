defmodule Filters.Condition.Of do
  @behaviour Filters.Behaviour.Condition

  import Filters

  @impl true
  def filter_callback(args), do: by([args])
end
