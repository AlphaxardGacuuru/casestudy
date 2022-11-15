# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Casestudy.Repo.insert!(%Casestudy.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Casestudy.Repo
alias Casestudy.Store

import Ecto.Query, warn: false

products = [
  %{:name => 1, :inventory => 10},
  %{:name => 2, :inventory => 2},
  %{:name => 3, :inventory => 2},
  %{:name => 4, :inventory => 6},
  %{:name => 5, :inventory => 1},
  %{:name => 6, :inventory => 8},
  %{:name => 7, :inventory => 8},
  %{:name => 8, :inventory => 4},
  %{:name => 9, :inventory => 0},
  %{:name => 10, :inventory => 0}
]

# Delete data before inserting
Repo.delete_all(Store.Order)
Repo.delete_all(Store.Product)

# Insert multiple products
for n <- products do
  Store.create_product(%{name: "Product #{n.name}", inventory: n.inventory})
end

# Get products
products = from(p in Store.Product, order_by: p.id, limit: 5) |> Repo.all()

for product <- products do
  Store.create_order(%{product_id: product.id + 1, quantity: 10, fulfilled: true})
end
