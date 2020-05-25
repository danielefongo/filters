defmodule Filters.Repo do
  use Ecto.Repo,
    otp_app: :filters,
    adapter: Ecto.Adapters.Postgres
end
