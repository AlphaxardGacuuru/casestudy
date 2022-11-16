defmodule CasestudyWeb.OrderControllerTest do
  use CasestudyWeb.ConnCase

  import Casestudy.StoreFixtures

  alias Casestudy.Store.Order

  @create_attrs %{
    fulfilled: false,
    product_id: 42,
    quantity: 10
  }
  @update_attrs %{
    fulfilled: true,
    product_id: 43,
    quantity: 10
  }
  @invalid_attrs %{fulfilled: nil, product_id: nil, quantity: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200) == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "fulfilled" => false,
               "id" => ^id,
               "product_id" => 42,
               "quantity" => 10
             } = json_response(conn, 200)
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.order_path(conn, :delete, order))
      assert %{"message" => "Order deleted"} = json_response(conn, 200)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_path(conn, :show, order))
      end
    end
  end

  defp create_order(_) do
    order = order_fixture()
    %{order: order}
  end
end
