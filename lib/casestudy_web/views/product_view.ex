defmodule CasestudyWeb.ProductView do
  use CasestudyWeb, :view
  alias CasestudyWeb.ProductView
  alias Casestudy.Store.Order

  def render("index.json", %{products: products}) do
    render_many(products, ProductView, "product.json")
  end

  def render("show.json", %{product: product}) do
    render_one(product, ProductView, "product.json")
  end

  def render("product.json", %{product: product}) do
    # Get latest unfulfilled order
    order = Order.latest_unfulfilled_order(product.id)

    # Check if latest order exists
    if order do
      # Turn order number to String
      string_id = Integer.to_string(order.id)

      length = String.length(string_id)

      # Format order number
      formated_order_number = String.slice("000000", length..6) <> string_id

      %{
        id: product.id,
        name: product.name,
        inventory: product.inventory,
        reorder: length(product.orders),
        order_number: formated_order_number
      }
    else
      %{
        id: product.id,
        name: product.name,
        inventory: product.inventory,
        reorder: length(product.orders),
        order_number: nil
      }
    end
  end
end
