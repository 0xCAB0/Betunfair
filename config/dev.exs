use Mix.Config

config :betunfair, ecto_repos: [BetUnfair.Repo]

config :betunfair, BetUnfair.Repo,
  adapter: Ecto.Adapters.MyXQL,
  database: "betunfair",
  username: "betunfair",
  password: "9sX5^6a2jJng",
  hostname: "localhost",
  port: 3306
