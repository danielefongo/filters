defmodule Filters.MixProject do
  use Mix.Project

  def project do
    [
      app: :filters,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:credo, "~> 1.4", only: [:dev, :test]},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      "ecto.init": ["ecto.create --quiet", "ecto.migrate --quiet"],
      test: ["ecto.init", "test"],
      check: [
        "compile --all-warnings --ignore-module-conflict --warnings-as-errors --debug-info",
        "format.check",
        "credo -a",
        "dialyzer"
      ],
      "format.all": [
        "format mix.exs 'lib/**/*.{ex,exs}' 'test/**/*.{ex,exs}' 'config/*.{ex,exs}'"
      ],
      "format.check": [
        "format --check-formatted mix.exs 'lib/**/*.{ex,exs}' 'test/**/*.{ex,exs}' 'config/*.{ex, exs}'"
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
