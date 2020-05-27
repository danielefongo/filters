defmodule Filters.Take.None do
  @behaviour Filters.Behaviour.Take

  import Ecto.Query

  @impl true
  def run([], _filter), do: true
  def run([data | others], filter), do: dynamic(^run(data, filter) and ^run(others, filter))
  def run(data, filter), do: dynamic(not (^filter.(data)))
end
