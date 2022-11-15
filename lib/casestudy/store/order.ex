defmodule Casestudy.Store.Order do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query, warn: false
  alias Casestudy.Repo
  alias Casestudy.Store
  alias Casestudy.Store.Order

  schema "orders" do
    field :product_id, :integer
    field :quantity, :integer
    field :fulfilled, :boolean

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:product_id, :quantity, :fulfilled])
    |> validate_required([:product_id, :quantity, :fulfilled])
  end

  # Reorder
  def reorder(id) do
    # Check if an unfulfilled order for the current product exists
    if !latest_unfulfilled_order(id) do
      Store.create_order(%{
        product_id: id,
        quantity: 10,
        fulfilled: false
      })
    end
  end

  def latest_unfulfilled_order(id) do
    # Get latest order of current product
    from(o in Order,
      where: o.product_id == ^id,
      where: o.fulfilled == false,
      order_by: o.id,
      limit: 1
    )
    |> Repo.all()
    |> Enum.at(0)
  end
end
