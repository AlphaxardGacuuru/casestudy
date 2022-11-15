defmodule CasestudyWeb.OrderView do
  use CasestudyWeb, :view
  alias CasestudyWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      product_id: order.product_id,
      quantity: order.quantity,
      fulfilled: order.fulfilled
    }
  end
end
