defmodule Filters.Condition.Deep do
  use Filters.Condition.Generic
  import Filters

  def filter_callback(args), do: by(args)
end
