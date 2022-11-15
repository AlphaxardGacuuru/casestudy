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

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Store.get_order!(id)

    with {:ok, %Order{} = order} <- Store.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Store.get_order!(id)

    with {:ok, %Order{}} <- Store.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
