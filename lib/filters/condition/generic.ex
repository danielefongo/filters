defmodule Filters.Condition.Generic do
  defmacro __using__(_) do
    quote do
      import Ecto.Query

      def run(kind, data), do: apply(Filters, kind, [data, & filter_callback/1])
    end
  end
end
