defmodule Casestudy.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :product_id, :integer
      add :quantity, :string
      add :fulfilled, :boolean, default: false, null: false

      timestamps()
    end
  end
end
