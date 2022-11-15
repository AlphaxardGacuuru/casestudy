defmodule Casestudy.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :inventory, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :inventory])
    |> validate_required([:name, :inventory])
  end
end
