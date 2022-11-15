defmodule Casestudy.Store.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :fulfilled, :boolean, default: false
    field :product_id, :integer
    field :quantity, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:product_id, :quantity, :fulfilled])
    |> validate_required([:product_id, :quantity, :fulfilled])
  end
end
