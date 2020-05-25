use Mix.Config

config :filters, Filters.Repo,
  database: "filters",
  username: "filters",
  password: "filters",
  hostname: System.get_env("DB_HOSTNAME", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

config :filters, ecto_repos: [Filters.Repo]
