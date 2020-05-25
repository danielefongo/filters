use Mix.Config

config :filters, Filters.Repo,
  database: "filters",
  username: "filters",
  password: "filters",
  hostname: "db"

config :filters, ecto_repos: [Filters.Repo]
