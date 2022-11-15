defmodule CasestudyWeb.ProductController do
  use CasestudyWeb, :controller

  alias Casestudy.Store
  alias Casestudy.Store.Product
  alias Casestudy.Store.Order

  action_fallback CasestudyWeb.FallbackController

  def index(conn, _params) do
    products = Store.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Store.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Store.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id}) do
    product = Store.get_product!(id)

    # Decrease inventory by 1
    inventory = product.inventory - 1

    # Check if inventory is below predefined level
    if inventory < 5 do
      Order.reorder(product.id)
    end

    Store.update_product(product, %{inventory: inventory})

    put_status(conn, 200)
    |> json(%{message: "Product Sold"})
  end

  def delete(conn, %{"id" => id}) do
    product = Store.get_product!(id)

    with {:ok, %Product{}} <- Store.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
