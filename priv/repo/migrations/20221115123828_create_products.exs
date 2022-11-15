defmodule Casestudy.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :inventory, :integer

      timestamps()
    end
  end
end
