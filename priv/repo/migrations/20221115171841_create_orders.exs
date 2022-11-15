defmodule Casestudy.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :product_id, :integer
      add :quantity, :integer
      add :fulfilled, :boolean, default: false

      timestamps()
    end
  end
end
