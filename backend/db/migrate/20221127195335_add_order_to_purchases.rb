class AddOrderToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_reference :purchases, :order, null: false, foreign_key: true
  end
end
