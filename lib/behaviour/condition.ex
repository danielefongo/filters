defmodule Filters.Behaviour.Condition do
  @callback filter_callback(term()) :: boolean() | %Ecto.Query.DynamicExpr{}
end
