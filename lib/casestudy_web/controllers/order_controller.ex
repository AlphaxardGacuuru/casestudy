defmodule CasestudyWeb.OrderController do
  use CasestudyWeb, :controller

  alias Casestudy.Store
  alias Casestudy.Store.Order

  action_fallback CasestudyWeb.FallbackController

  def index(conn, _params) do
    orders = Store.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Store.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Store.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "quantity" => quantity}) do
    order = Store.get_order!(id)

    Store.update_order(order, %{quantity: quantity})

    put_status(conn, 200)
    |> json(%{message: "Order Updated"})
  end

  def update(conn, %{"id" => id}) do
    order = Store.get_order!(id)

    # Get product
    product = Store.get_product!(order.product_id)

    # Increase inventory
    new_inventory = product.inventory + order.quantity

    # Update product inventory
    Store.update_product(product, %{inventory: new_inventory})

    Store.update_order(order, %{fulfilled: true})

    put_status(conn, 200)
    |> json(%{message: "Order Dispatched"})
  end

  def delete(conn, %{"id" => id}) do
    order = Store.get_order!(id)

    Store.delete_order(order)

    put_status(conn, 200)
    |> json(%{message: "Order deleted"})
  end
end
