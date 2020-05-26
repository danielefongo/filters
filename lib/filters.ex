defmodule Filters do
  import Ecto.Query
  alias Filters.Take.All

  def filter(query, nil), do: query
  def filter(query, filter), do: where(query, ^filter)

  defmacro by(args) do
    quote bind_quoted: [args: args] do
      args
      |> Enum.map(fn {key, options} ->
        [condition_string, take_string | _] = String.split(Atom.to_string(key), "_")

        condition =
          String.to_existing_atom("Elixir.Filters.Condition." <> Macro.camelize(condition_string))

        take = String.to_existing_atom("Elixir.Filters.Take." <> Macro.camelize(take_string))

        apply(condition, :run, [take, options])
      end)
      |> All.run(fn echoed -> echoed end)
    end
  end
end
