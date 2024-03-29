defmodule BetUnfair.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_id, :binary_id, autogenerate: true}

  schema "user" do
    field :username, :string
    field :full_name, :string
    field :password, :string
    field :balance, :integer
    timestamps(type: :utc_datetime, inserted_at: :inserted_at, updated_at: :updated_at)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username, :full_name, :password, :balance])
    |> validate_required([:username, :full_name])
    |> unique_constraint(:username, name: :user_username_index)
  end
end
