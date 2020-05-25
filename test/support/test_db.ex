defmodule DbTest do
  defmacro __using__(_) do
    quote do
      alias Filters.{Repo, Sample}

      setup do
        Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        :ok
      end
    end
  end
end
