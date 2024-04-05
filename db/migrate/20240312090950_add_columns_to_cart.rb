class AddColumnsToCart < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :validated, :boolean, null: false, default: false
    # add_column :carts, :price, :decimal, null: false, default: 0.0
  end
end
