defmodule Filters.Condition.Generic do
  defmacro __using__(_) do
    quote do
      import Ecto.Query
      @behaviour Filter.ConditionBehaviour

      def run(kind, data), do: apply(Filters, kind, [data, &filter_callback/1])
    end
  end
end

defmodule Filter.ConditionBehaviour do
  @callback filter_callback(term()) :: boolean() | %Ecto.Query.DynamicExpr{}
end
