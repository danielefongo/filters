defmodule Filters.Behaviour.Take do
  @callback run(term(), function()) :: boolean() | %Ecto.Query.DynamicExpr{}
end
