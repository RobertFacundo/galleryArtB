class ChangeCoinsAndPriceToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :coins, :decimal, precision: 10, scale: 2, default: 10.0, null: false
    change_column :artworks, :price, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
