defmodule Filters.Take.Any do
  import Ecto.Query
  def run([], _filter), do: false
  def run([data | others], filter), do: dynamic(^run(data, filter) or ^run(others, filter))
  def run(data, filter), do: dynamic(^filter.(data))
end
