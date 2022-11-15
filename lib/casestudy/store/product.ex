defmodule Casestudy.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Casestudy.Store.Order

  schema "products" do
    field :inventory, :integer
    field :name, :string
    has_many :orders, Order, foreign_key: :product_id

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :inventory])
    |> validate_required([:name, :inventory])
  end
end
