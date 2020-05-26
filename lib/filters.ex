defmodule Filters do
  import Ecto.Query

  def filter(query, nil), do: query
  def filter(query, filter), do: where(query, ^filter)

  def all([], _filter), do: true
  def all([data], filter), do: dynamic(^filter.(data))
  def all([data | others], filter), do: dynamic(^filter.(data) and ^all(others, filter))

  def any([], _filter), do: false
  def any([data], filter), do: dynamic(^filter.(data))
  def any([data | others], filter), do: dynamic(^filter.(data) or ^any(others, filter))

  def none([], _filter), do: true
  def none([data], filter), do: dynamic(not ^filter.(data))
  def none([data | others], filter), do: dynamic(not (^filter.(data)) and ^none(others, filter))

  defmacro by(args) do
    quote bind_quoted: [args: args] do
      args
      |> Enum.map(fn {[module, kind], options} -> apply(module, :run, [kind, options]) end)
      |> Filters.all(fn echoed -> echoed end)
    end
  end
end
