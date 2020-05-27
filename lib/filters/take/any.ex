defmodule Filters.Take.Any do
  @behaviour Filters.Behaviour.Take

  import Ecto.Query

  @impl true
  def run([], _filter), do: false
  def run([data | others], filter), do: dynamic(^run(data, filter) or ^run(others, filter))
  def run(data, filter), do: dynamic(^filter.(data))
end
