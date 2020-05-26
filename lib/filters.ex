defmodule Filters do
  import Ecto.Query

  defmacro by(args) do
    quote bind_quoted: [args: args] do
      Enum.map(args, fn {[module, kind], options} -> apply(module, :run, [kind, options]) end)
    end
  end

  def filter(query, nil), do: query
  def filter(query, filters), do: Enum.reduce(filters, query, &filter_next/2)
  defp filter_next(filter, query), do: where(query, ^filter)
end
