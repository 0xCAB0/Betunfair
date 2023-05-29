defmodule BetUnfair.Schemas.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  defmodule BetUnfair.Schemas.Bet.Status do
    @behaviour Ecto.Type

    @type t ::
            :active
            | :cancelled
            | :market_cancelled
            | {:market_settled, boolean()}

    @t [
      :active,
      :cancelled,
      :market_cancelled,
      {:market_settled, true},
      {:market_settled, false}
    ]

    @impl Ecto.Type
    def type, do: :string

    @impl Ecto.Type
    def cast(value) when value in @t, do: {:ok, value}
    def cast(_), do: :error

    @impl Ecto.Type
    def dump(value) when value in @t do
      case is_tuple(value) do
        false -> {:ok, to_string(value)}
        true -> {:ok, to_string(elem(value, 1))}
        end
    end

    def dump(_), do: :error

    @impl Ecto.Type
    def load(value) when is_binary(value) do
      case value do
        "active" -> {:ok, :active}
        "cancelled" -> {:ok, :cancelled}
        "market_cancelled" -> {:ok, :market_cancelled}
        "true" -> {:ok, {:market_settled, true}}
        "false" -> {:ok, {:market_settled, false}}
        _ -> :error
      end
    end

    def load(_), do: :error

    @impl Ecto.Type
    def embed_as(_), do: :string

    @impl Ecto.Type
    def equal?(value1, value2), do: value1 == value2
  end


  @primary_key {:bet_id, :binary_id, autogenerate: true}

  schema "bet" do
    field(:username, :string)
    field(:market_id, :integer)
    field(:amount, :float)
    field(:remaining_amount, :float)
    field(:odds, :float)
    field(:bet_type, :string)
    field(:is_matched, :boolean)
    field(:status, BetUnfair.Schemas.Bet.Status, default: :active)
    timestamps( inserted_at: :inserted_at, updated_at: :updated_at)
  end

  def changeset(bet, params \\ %{}) do
    bet
    |> cast(params, [:bet_id, :username, :market_id, :amount, :remaining_amount, :odds, :bet_type, :is_matched])
    |> validate_required([:username, :market_id])
  end
end
