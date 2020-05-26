defmodule Filters do
  import Ecto.Query

  def filter(query, nil), do: query
  def filter(query, filter), do: where(query, ^filter)

  def all([], _filter), do: true
  def all([data | others], filter), do: dynamic(^all(data, filter) and ^all(others, filter))
  def all(data, filter), do: dynamic(^filter.(data))

  def any([], _filter), do: false
  def any([data | others], filter), do: dynamic(^any(data, filter) or ^any(others, filter))
  def any(data, filter), do: dynamic(^filter.(data))

  def none([], _filter), do: true
  def none([data | others], filter), do: dynamic(^none(data, filter) and ^none(others, filter))
  def none(data, filter), do: dynamic(not ^filter.(data))

  defmacro by(args) do
    quote bind_quoted: [args: args] do
      args
      |> Enum.map(fn {[module, kind], options} -> apply(module, :run, [kind, options]) end)
      |> Filters.all(fn echoed -> echoed end)
    end
  end
end
