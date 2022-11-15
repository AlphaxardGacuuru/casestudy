defmodule Casestudy.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Casestudy.Store` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        inventory: 42,
        name: "some name"
      })
      |> Casestudy.Store.create_product()

    product
  end

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        fulfilled: true,
        product_id: 42,
        quantity: "some quantity"
      })
      |> Casestudy.Store.create_order()

    order
  end
end
