defmodule BetUnfair.Repo do
  use Ecto.Repo,
    otp_app: :betunfair,
    adapter: Ecto.Adapters.MyXQL
end
