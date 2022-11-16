defmodule CasestudyWeb.ProductControllerTest do
  use CasestudyWeb.ConnCase

  import Casestudy.StoreFixtures

  alias Casestudy.Store.Product

  @create_attrs %{
    inventory: 40,
    name: "some name"
  }
  @update_attrs %{
    inventory: 5,
    name: "some updated name"
  }
  @invalid_attrs %{inventory: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert json_response(conn, 200) == []
    end
  end

  describe "update product" do
    setup [:create_product]

    test "check inventory has decremented", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)
      assert %{"message" => "Product Sold"} = json_response(conn, 200)

      conn = get(conn, Routes.product_path(conn, :show, id))

      assert 4 = json_response(conn, 200)["inventory"]
    end

    test "check order is created", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)

      conn = get(conn, Routes.order_path(conn, :index))

      orders = json_response(conn, 200)
      assert length(orders) > 0
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
