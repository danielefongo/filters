defmodule Filters.Take.None do
  import Ecto.Query
  def run([], _filter), do: true
  def run([data | others], filter), do: dynamic(^run(data, filter) and ^run(others, filter))
  def run(data, filter), do: dynamic(not (^filter.(data)))
end
